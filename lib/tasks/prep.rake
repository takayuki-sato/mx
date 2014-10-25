def updateName (currentName, newName)
  if currentName && !currentName.include?(newName)
    currentName += ", #{newName}"
  else
    currentName = newName
  end
  currentName
end

namespace :db do
  desc 'zipcode'
  task :zipcode => :environment do
    LISTS = ['http://www.geopostcodes.com/Monterrey_Nuevo_Leon', 'http://www.geopostcodes.com/Guadalajara_Jalisco']
      # format is as follows
      #<tr itemscope itemtype="http://schema.org/City">
        #<td itemprop="name">Monterrey<span>Arboledas de San Bernabe</span>
        #</td>
        #<td></td>
        #<td>64103</td>
        #<td><div class="rec" id="1002513590"></div></td>
      #</tr>

    LISTS.each do |url|
      doc = Nokogiri::HTML.parse RestClient.get(url)
      objects = doc.xpath("//tr[@itemtype='http://schema.org/City']")

      objects.each do |row|
        # here is the specific logic to be extracted to a function
        city = row.children[0].inner_html.match('^.+<s').to_s[0...-2]
        town = row.children[0].inner_html.match('>.+<').to_s.delete('><')
        codes = row.children[2].inner_html.split(',')

        codes.each_with_index do |zipcode, i|
          town_name = codes.length > 1 ? "#{town} (#{i + 1})" : town
          area = Area.find_or_create_by(zipcode: zipcode.strip)
          area.city = updateName area.city, city
          area.town = updateName area.town, town_name
          area.save
        end
      end
    end

    Area.all.each do |area|
      puts area.inspect
    end
  end
end