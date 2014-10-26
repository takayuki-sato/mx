def updateName (current_name, new_name)
  if current_name && !current_name.include?(new_name)
    s = StringScanner.new(new_name)
    appending_name = ''
    while !s.eos? do
      word = s.scan(/\w+/)
      if word
        appending_name += " #{word}" if !current_name.include?(word)
      else
        s.get_byte
      end
    end
    current_name += ",#{appending_name}" if appending_name.length > 0
  else
    current_name = new_name
  end
  current_name
end

DOMAIN = 'http://www.geopostcodes.com/'

namespace :db do
  desc 'zipcode'
  task :zipcode => :environment do
    LISTS = ['Monterrey_Nuevo_Leon', 'Guadalajara_Jalisco']
      # format is as follows
      #<tr itemscope itemtype="http://schema.org/City">
        #<td itemprop="name">Monterrey<span>Arboledas de San Bernabe</span>
        #</td>
        #<td></td>
        #<td>64103</td>
        #<td><div class="rec" id="1002513590"></div></td>
      #</tr>

    LISTS.each do |url|
      puts "- working at #{url}"

      doc = Nokogiri::HTML.parse RestClient.get(DOMAIN + url)
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

    if !Rails.env.production?
      Area.all.each do |area|
        puts area.inspect
      end
    end
  end

  desc 'municipalities in Mexico city'
  task :mdf => :environment do
    BASE = 'Mexico_City'
    CITY_NAME = 'México, D.F.'
    # format is as follows
    #<tr style='background-color:#eeece7' itemscope itemtype ='http://schema.org/AdministrativeArea'>
      #<td width='215'>
        #<a itemprop='name' href='Alvaro_Obregon_Distrito_Federal'>Álvaro Obregón</a>
      #</td>
      #<td><div class='code ign'>09010</div></td>
      #<td class='tdr'>248</td>
    #</tr>
    doc = Nokogiri::HTML.parse RestClient.get(DOMAIN + BASE)
    objects = doc.xpath("//tr[@itemtype='http://schema.org/AdministrativeArea']")

    puts '*** Failed to fetch the document ***' if not objects
    objects.each do |row|
      # here is the specific logic to be extracted to a function
      link = row.children[0].child["href"]
      name = row.children[0].child.inner_html
      key = row.children[1].child.inner_html

      data = Municipality.find_or_create_by(key: key)
      data.name = name
      data.save
      puts "- working at #{link}"

      # format is as follows
      #<tr itemscope itemtype = 'http://schema.org/City'>
        # <td itemprop='name'>2a Del Moral del Pueblo de Tetelpan</td>
        # <td></td>
        # <td>01700</td>
        # <td><div class='rec' id='1002455562'></div></td>
      # </tr>
      doc_area = Nokogiri::HTML.parse RestClient.get(DOMAIN + link)
      objects_area = doc_area.xpath("//tr[@itemtype='http://schema.org/City']")

      puts '*** Failed to fetch the document ***' if not objects_area
      objects_area.each do |row_area|
        town = row_area.children[0].inner_html
        codes = row_area.children[2].inner_html.split(',')

        codes.each_with_index do |zipcode, i|
          town_name = codes.length > 1 ? "#{town} (#{i + 1})" : town
          area = Area.find_or_create_by(zipcode: zipcode.strip)
          area.city = CITY_NAME
          area.town = updateName area.town, town_name
          area.municipality_id = data.id
          area.save
        end
      end
    end

    if !Rails.env.production?
      Municipality.all.each do |data|
        puts data.inspect
      end
      Area.all.each do |area|
        puts area.inspect
      end
    end
  end

  desc 'availability of zipcode in open data'
  task :available => :environment do
    areas = Area.all
    areas.each do |area|
      data= Transaction.basic_stats_by_zipcode area.zipcode
      area.available = (data && data['result'] && data['result']['code'] == 200)
      area.save
      if !Rails.env.production?
        puts area.inspect
      end
    end
  end
end