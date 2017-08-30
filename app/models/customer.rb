class Customer < ActiveRecord::Base
	validates :first_name, :last_name, :phone_number, presence: true

	has_many :bookings, dependent: :destroy

	has_one :city, dependent: :destroy

	accepts_nested_attributes_for :city

	def full_name
    "#{first_name.try(:strip).try(:camelize)} #{last_name.try(:strip).try(:camelize)}".try(:parameterize).try(:titleize)
  end

	
end
