class Cleaner < ActiveRecord::Base
	validates :first_name, :last_name, :quality_score, presence: true
	validates_inclusion_of :quality_score, :in => 0.0..5.0

	def full_name
    	"#{first_name.try(:strip).try(:camelize)} #{last_name.try(:strip).try(:camelize)}".try(:parameterize).try(:titleize)
  	end
end
