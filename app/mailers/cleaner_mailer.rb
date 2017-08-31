class CleanerMailer < ApplicationMailer
	default from: 'dipakjadam@gmail.com'

	def assign_work(user)
		@user = user
		mail(to: @user.email, subject: 'assign new work')
	end
end
