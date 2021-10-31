class Booking < ApplicationRecord
  belongs_to :guest, class_name: "User" # indique que Booking appartient à un guest, qui est en fait de la classe User
  belongs_to :room

  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :start_must_be_before_end_date
  validate :start_date_must_be_from_today
  validate :overlaps_with_other?

  def duration? #convertir secondes en jours (et type integer)
    (end_date - start_date).to_i/(3600*24) #https://stackoverflow.com/questions/4502245/how-can-i-find-the-number-of-days-between-two-date-objects-in-ruby
  end

  def total_price?
    price_unit = room.price_unit
    booking_duration = booking.duration?
    total_price = price_unit * booking_duration
    return total_price
  end

  def period
    start_date..end_date
  end

  private # pour éviter qu'une méthode soit appelée en dehors de la classe (car elle n'est utile qu'au sein meme de cette classe) >>> https://www.rubyguides.com/2018/10/method-visibility/
  
  def start_must_be_before_end_date #https://stackoverflow.com/questions/6401374/rails-validation-method-comparing-two-fields
    errors.add(:start_date, "Start date must be before end date") unless start_date < end_date
  end

  def start_date_must_be_from_today
    errors.add(:start_date, "Start date must be from today") if start_date > Time.now # idem que unless start_date > Time.now
  end

  def overlaps_with_other? # vérifie dans toutes les réservations du listing s'il y a une réservation qui tombe sur le datetime en entrée #https://railsguides.net/date-ranges-overlap/
    other_bookings = Booking.all
    is_overlapping = other_bookings.any? do |other_booking| # any? method >>> https://www.geeksforgeeks.org/ruby-enumerable-any-function/#:~:text=The%20any%3F()%20of%20enumerable,condition%2C%20else%20it%20returns%20false.&text=Parameters%3A%20The%20function%20takes%20two,the%20other%20is%20the%20pattern.
      period.overlaps?(other_booking.period) # overlaps? method >>> https://www.rubydoc.info/docs/rails/Range:overlaps%3F
    end
    errors.add(:overlaps_with_other?, "The room is already booked at this period") if is_overlapping # la méthode .any? retourne déjà un boolean true or false
  end
    
    
    #Room.bookings.each do |booking|
    #  started_at = booking.start_date
    #  ended_at = booking.end_date
    #  if period2.start_date.to_i < period1.end_date.to_i || period2.end_date.to_i < period1.end_date.to_i
    #    return errors.add(:booking_status, "Room already booked") 
    #  end
    #end

end
