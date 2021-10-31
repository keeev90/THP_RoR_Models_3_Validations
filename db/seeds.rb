# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

# Vider les tables à chaque nouveau seed via $ rails db:seed
City.destroy_all 
User.destroy_all 
Room.destroy_all
Booking.destroy_all

# Table cities
zip_codes = ["75000", "90000", "91000", "92000", "93000", "94000", "95000", "33000", "23000", "78000"]
10.times do |i|
  city = City.create!(
    name: Faker::Address.unique.city,
    zip_code: zip_codes[i]
  )
end

# Table users
20.times do |d|
  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.unique.email,
    phone_number: "0" + rand(600000000..799999999).to_s,
    profile_description: Faker::Lorem.sentence
  )
end

# Tables rooms & bookings
# 50 rooms
50.times do
  room = Room.create!(
    title: Faker::Lorem.paragraph_by_chars(number: 30, supplemental: false),
    room_description: Faker::Lorem.paragraph_by_chars(number: 100, supplemental: true),
    adress: Faker::Address.street_address,
    price_unit: Faker::Number.within(range: 1..5000),
    beds_available: Faker::Number.within(range: 1..20),
    booking_available: Faker::Boolean.boolean(true_ratio: 0.8),
    wifi_available: Faker::Boolean.boolean,
    welcome_message: Faker::Lorem.sentence,
    city_id: City.ids.sample,
    host_id: User.ids.sample
  )

  # 5 past bookings pour chaque room
  5.times do
    start_date = Faker::Date.backward(days: rand(1..3000))
    past_booking = Booking.create!(
      start_date: start_date,
      end_date: start_date.advance(days: rand(1..7)),
      guest_id: User.ids.sample,
      room_id: room.id
    )
  end

  # 5 future bookings pour chaque room
  5.times do
    start_date = Faker::Date.forward(days: rand(1..3000))
    future_booking = Booking.create!(
      start_date: start_date,
      end_date: start_date.advance(days: rand(1..7)),
      guest_id: User.ids.sample,
      room_id: room.id
    )
  end
end