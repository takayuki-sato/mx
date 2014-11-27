def auto (area, calculation)
  res = Transaction.category_distribution_by_zipcode area.zipcode
  return if (res.blank? || res['result'].blank? || res['result']['code'] != 200)

  res['data']['stats'].each do |month_res|
    month_res['histogram'].each do |category_res|
      label = category_res['label']
      amount = category_res['num_payments'] * month_res['avg']

      calculation.auto += amount if label == 'mx_auto'
    end
  end

  calculation
end

def engel (area, calculation)
  res = Transaction.category_distribution_by_zipcode area.zipcode
  return if (res.blank? || res['result'].blank? || res['result']['code'] != 200)

  res['data']['stats'].each do |month_res|
    month_res['histogram'].each do |category_res|
      label = category_res['label']
      amount = category_res['num_payments'] * month_res['avg']

      tag = Category.where(name: category_res['label']).first.tag
      if tag.include? 'basic' then
        calculation.basic += amount
      elsif tag.include? 'advanced' then
        calculation.advanced += amount
      elsif tag.include? 'professional' then
        calculation.professional += amount
      elsif tag.include? 'others' then
        calculation.other_category += amount
      end
    end
  end

  if calculation.advanced > 0
    calculation.engel = calculation.basic.to_f / (calculation.basic.to_f + calculation.advanced.to_f)
  end

  calculation
end

def consumer_and_age (area, calculation)
  res = Transaction.payments_cube_by_zipcode area.zipcode
  return if (res.blank? || res['result'].blank? || res['result']['code'] != 200)

  res['data']['stats'].each do |month_res|
    month_res['cube'].each do |cube_res|
      label = cube_res['hash']
      amount = cube_res['num_payments'] * cube_res['avg']

      # consumer index
      if label.match(/^M#\w+#\d+$/)
        calculation.male += amount
      elsif label.match(/^F#\w+#\d+$/)
        calculation.female += amount
      elsif label.match(/^E#\w+#\d+$/)
        calculation.enterprise += amount
      elsif label.match(/^U#\w+#\d+$/)
        calculation.unknown += amount
      end

      # age index
      if label.match(/^\w+#0#\d+$/)
        calculation.age_0 += amount
      elsif label.match(/^\w+#1#\d+$/)
        calculation.age_1 += amount
      elsif label.match(/^\w+#2#\d+$/)
        calculation.age_2 += amount
      elsif label.match(/^\w+#3#\d+$/)
        calculation.age_3 += amount
      elsif label.match(/^\w+#4#\d+$/)
        calculation.age_4 += amount
      elsif label.match(/^\w+#5#\d+$/)
        calculation.age_5 += amount
      elsif label.match(/^\w+#6#\d+$/)
        calculation.age_6 += amount
      elsif label.match(/^\w+#U#\d+$/)
        calculation.age_u += amount
      end
    end
  end

  # consumer index
  if calculation.enterprise > 0
    calculation.consumer = (calculation.male.to_f + calculation.female.to_f) /
      (calculation.male.to_f + calculation.female.to_f + calculation.enterprise.to_f)
  end

  # age index
  if calculation.age_3 + calculation.age_4 + calculation.age_5 + calculation.age_6 > 0
    calculation.young = (calculation.age_1.to_f + calculation.age_2.to_f) /
      (calculation.age_1.to_f + calculation.age_2.to_f +
      calculation.age_3.to_f + calculation.age_4.to_f +
      calculation.age_5.to_f + calculation.age_6.to_f)
  end

  calculation
end

def update_availability (area, calculation)
  if calculation.engel == 0 && calculation.consumer == 0 && calculation.young == 0
    area.available = false
    area.save
  end
end

namespace :db do
  desc 'tagging the category'
  task :tag => :environment do
    categories = Category.all
    classification = {
        'basic' => ['mx_barsandrestaurants', 'mx_food'],
        'advanced' => ['mx_auto', 'mx_beauty', 'mx_book', 'mx_education', 'mx_fashion', 'mx_health', 'mx_home',
                       'mx_hyper', 'mx_jewelry', 'mx_leisure', 'mx_music', 'mx_pet', 'mx_shoes', 'mx_sport', 'mx_tech', 'mx_travel'],
        'professional' => ['mx_constructionmaterials', 'mx_office', 'mx_services'],
        'others' => ['mx_others']
    }
    categories.each do |category|
      classification.each do |key, array|
        if array.include? category.name
          if ENV['FORCE'] || (!ENV['FORCE'] && category.tag.blank?)
            category.tag = key
          else
            category.tag += ", #{key}"
          end
          category.save
          break
        end
      end
    end
  end

  desc 'basic analysis'
  task :basic => :environment do
    areas = Area.where(available: true)
    areas.where(city: 'Monterrey') if !Rails.env.production? || ENV['FORCE']

    areas.each do |area|
      calculation = area.calculation || area.create_calculation
      calculation = engel area, calculation
      calculation = consumer_and_age area, calculation
      update_availability area, calculation

      calculation.save
    end

    if !Rails.env.production?
      Calculation.all.each do |data|
        puts data.inspect
      end
    end
  end

  desc 'geocode'
  task :geocode => :environment do
    areas = Area.where(available: true)
    areas.where(city: 'Monterrey') if !Rails.env.production? || ENV['FORCE']

    areas.each do |area|
      puts "- working at #{area.town}, #{area.city}"
      calculation = area.calculation || area.create_calculation

      area.geocode
      area.available = false if area.calculation && area.calculation.formatted_address.blank?
      area.calculation.save if area.calculation
      area.save
    end

    if !Rails.env.production?
      Calculation.all.each do |data|
        puts data.inspect
      end
    end
  end

  desc 'auto'
  task :auto => :environment do
    areas = Area.where(available: true)
    areas.where(city: 'Monterrey').first if !Rails.env.production? || ENV['FORCE']

    areas.each do |area|
      puts "- working at #{area.town}, #{area.city}"

      calculation = area.calculation || area.create_calculation
      calculation = auto area, calculation
      calculation.save
    end

    if !Rails.env.production?
      Calculation.all.each do |data|
        puts data.inspect
      end
    end
  end
end