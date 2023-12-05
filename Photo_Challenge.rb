def solution(s)
  # 1: Parse the input string
  # Split the input into lines...
  photos = s.split("\n").map do |line|
    # ...and then each line into its components
    # Split photo name from the extension
    name, extension = line.split(',')[0].split('.')
    # Strip to deal with whitespace
    city = line.split(',')[1].strip
    timestamp = line.split(',')[2].strip
    { name: name, extension: extension, city: city, timestamp: timestamp }
  end

  # 2: Group photos by city
  # Using group_by to create location groups
  grouped_photos = photos.group_by { |photo| photo[:city] }
  # Now grouped_photos = {
  #  "City1"=>[{photo1_data_in_city1}, {photo2_data_in_city1}],
  #  "City2"=>[{photo1_data_in_city2}, {photo2_data_in_city2}, .....]}

  # 3: Sort city photos in each group by timestamp
  # This will allow us to assign consecutive nums
  grouped_photos.each do |city, city_photos|
    city_photos.sort_by! { |photo| photo[:timestamp] }
  end

  # 4: Rename photos
  # Create a hash to map original names to new names
  # This will allow us to keep the original order of the input string
  name_map = {}
  grouped_photos.each do |city, city_photos|
    # Calculating the number length for zero padding
    number_length = city_photos.length.to_s.length # `10` has length 2
    city_photos.each_with_index do |photo, index|
      # Constructing the new name with padding and city name
      new_name = "#{city}#{(index + 1).to_s.rjust(number_length, '0')}.#{photo[:extension]}"
      original_name = "#{photo[:name]}.#{photo[:extension]}"
      name_map[original_name] = new_name
    end
  end

  # 5: Map over the original photos list, grabbing the new name for each photo and create the final string
  photos.map { |photo| name_map["#{photo[:name]}.#{photo[:extension]}"] }.join("\n")
end

# TESTING - using provided assumptions on the pdf about newline characters

photo_string1 = "photo.jpg, Krakow, 2013-09-05 14:08:15 Mike.png, London, 2015-06-20 15:13:22\nmyFriends.png, Krakow, 2013-09-05 14:07:13\nEiffel.jpg, Florianopolis, 2015-07-23 08:03:02\npisatower.jpg, Florianopolis, 2015-07-22 23:59:59\nBOB.jpg, London, 2015-08-05 00:02:03\nnotredame.png, Florianopolis, 2015-09-01 12:00:00\nme.jpg, Krakow, 2013-09-06 15:40:22\na.png, Krakow, 2016-02-13 13:33:50\nb.jpg, Krakow, 2016-01-02 15:12:22\nc.jpg, Krakow, 2016-01-02 14:34:30\nd.jpg, Krakow, 2016-01-02 15:15:01\ne.png, Krakow, 2016-01-02 09:49:09\nf.png, Krakow, 2016-01-02 10:55:32\ng.jpg, Krakow, 2016-02-29 22:13:11"

photo_string2 = "sunset.png, Phoenix, 2017-04-18 20:30:00\nlandscape.jpg, Phoenix, 2017-05-10 15:07:22\nskyline.jpg, NewYork, 2018-09-12 18:45:30\nseaside.jpg, Sydney, 2019-03-22 06:12:00\nopera.png, Sydney, 2019-03-25 19:20:15\nbridge.jpg, NewYork, 2018-10-05 08:25:50\npark.jpg, Phoenix, 2017-06-01 12:30:45\nstreet.jpg, Sydney, 2019-04-05 14:00:00\nmuseum.png, Phoenix, 2017-07-08 10:45:30\nharbor.jpg, Sydney, 2019-05-15 16:20:00\nbuilding.jpg, NewYork, 2018-11-10 11:00:22\ntower.jpg, Phoenix, 2017-08-20 09:30:00"


output1 = solution(photo_string1)
output2 = solution(photo_string2)


puts output1
puts "----------"
puts output2

