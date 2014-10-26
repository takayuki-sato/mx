namespace :db do
  desc 'basic analysis'
  task :basic => :environment do
    areas = Area.where(available: true, city: 'Monterrey')
    data = []
    areas.each do |area|
      data.push Transaction.category_distribution_by_zipcode(area.zipcode)
      puts data.last
    end
    #puts data.inspect
  end
end