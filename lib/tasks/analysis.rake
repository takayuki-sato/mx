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
    areas = Area.where(available: true, city: 'Monterrey')
    area_responses = {}
    data = {}

    areas.each do |area|
      area_responses[area.zipcode] = Transaction.category_distribution_by_zipcode(area.zipcode)
    end
    area_responses.each do |zipcode, res|
      data[zipcode] = {
        'basic' => 0,
        'advanced' => 0,
        'professional' => 0,
        'others' => 0,
        'engel' => 0
      }

      res['data']['stats'].each do |month_res|
        month_res['histogram'].each do |category_res|
          label = category_res['label']
          amount = category_res['num_payments'] * month_res['avg']

          tag = Category.where(name: category_res['label']).first.tag
          if tag.include? 'basic' then
            data[zipcode]['basic'] += amount
          elsif tag.include? 'advanced' then
            data[zipcode]['advanced'] += amount
          elsif tag.include? 'professional' then
            data[zipcode]['professional'] += amount
          elsif tag.include? 'others' then
            data[zipcode]['others'] += amount
          end
        end
      end

      if data[zipcode]['basic'] + data[zipcode]['advanced'] > 0
        data[zipcode]['engel'] = data[zipcode]['basic'] / (data[zipcode]['basic'] + data[zipcode]['advanced'])
      end
    end
    puts data.inspect
  end
end