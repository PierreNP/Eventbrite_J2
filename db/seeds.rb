# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

[User, Event, Attendance].map {|tab| tab.destroy_all}
['users', 'events', 'attendances'].map {|tab| ActiveRecord::Base.connection.reset_pk_sequence!(tab)}

city_list = [["Paris","75000"],["Lyon","69000"],["Marseille","13000"],["Nice","06000"],["Bordeaux","33000"],["Strasbourg","67000"],["Rennes","35000"],["Toulouse","31000"],["Caen","14000"],["Toulon","83000"]]

# tag_list = ['Humour', 'evil', 'event', 'people', 'business', 'sport']

# 10.times do |i|
#   City.create(name: city_list[i][0], zip_code:city_list[i][1])
# end


50.times do
  User.create(first_name:Faker::Name.first_name,last_name:Faker::Name.last_name, password:Faker::Internet.password(min_length: 8), description:Faker::Lorem.sentences(number: 2).join(" "), email:Faker::Internet.email )
end

# tag_list.map {|tag| Tag.create(title: tag)}

10.times do
  event = Event.create(title:Faker::Lorem.words(number: 2).join(" "), description:Faker::Lorem.sentences(number: 2).join(" "), admin_id:rand(1..User.count),location:city_list[rand(0..(city_list.length-1))][0], price:rand(0..100),duration:rand(1..7), start_date:Faker::Date.between(from: '2021-01-01', to: '2021-12-31'))

  rand(5..15).times do
    	Attendance.create(attendee_id:rand(1..User.count), event_id:event.id)
  end

end