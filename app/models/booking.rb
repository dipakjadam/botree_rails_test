class Booking < ActiveRecord::Base
  belongs_to :customer
  belongs_to :cleaner
end
