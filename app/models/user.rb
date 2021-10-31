class User < ApplicationRecord
  has_many :rooms, foreign_key: 'host_id', class_name: "Room", dependent: :destroy # indique que le model User has_many rooms. Ces rooms correspondent à la colonne host_id de la classe Room >>> permet de faire des méthodes .host et .rooms
  has_many :bookings, foreign_key: 'guest_id', class_name: "Booking", dependent: :destroy # indique que le model User has_many bookings. Ces bookings correspondent à la colonne guest_id de la classe Booking >>> permet de faire des méthodes .guest et .bookings

  validates :first_name,
    presence: true
  
  validates :last_name,
    presence: true
  
  validates :email,
    presence: true,
    uniqueness: true,
    format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "Please enter a valid email adress" }  
  
  validates :phone_number,
    presence: true,
    format: { with: /\A(?:(?:\+|00)33[\s.-]{0,3}(?:\(0\)[\s.-]{0,3})?|0)[1-9](?:(?:[\s.-]?\d{2}){4}|\d{2}(?:[\s.-]?\d{3}){2})\z/, message: "Please enter a valid french phone number" }
end
