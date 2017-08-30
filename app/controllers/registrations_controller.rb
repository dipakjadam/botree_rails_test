class RegistrationsController < ApplicationController
	def sign_up
		@customer = Customer.new
		@customer.build_city
	end
end