class AttendenceMailer < ApplicationMailer
  def missing_attendence
  	@user = params[:user]
  	@date = params[:date]
  	mail(to: @user.email, subject: 'Attendence Missing')
  end
end
