namespace :batch do
  desc "TODO"
  task create_entry: :environment do
    AdminUser.where(role: "staff").each do |user|
      TimeSheet.create(date: Date.current, admin_user: user)
      AttendenceMailer.with(user: user, date: Date.current-1.day).missing_attendence.deliver_now if TimeSheet.find_by(date: Date.current-1.day, admin_user: user, is_present: false).present?
    end
  end

end
