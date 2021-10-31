class Room < ApplicationRecord
  attr_accessor :booking

  belongs_to :city
  belongs_to :host, class_name: "User" # indique que Room appartient à un host, qui est en fait de la classe User
  has_many :bookings

  validates :title,
    presence: true,
    length: { maximum: 30 }
  
  validates :room_description,
    presence: true,
    length: { minimum: 100 }

  validates :adress,
    presence: true
  
  validates :price_unit,
    presence: true,
    numericality: { only_integer: true },
    inclusion: {in: 1..5000}

  validates :beds_available,
    presence: true,
    numericality: { only_integer: true },
    inclusion: {in: 1..20}
  
  validates :wifi_available,
    inclusion: { in: [true, false] }
  
  validates :welcome_message,
    presence: true
  
end
