# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
%i[admin].each do |role|
  AdminUser.find_or_create_by!(email: "#{role}@poolstack.com") do |admin_user|
    admin_user.role = role
    admin_user.password = 'Q&9k4kwTR+4JgjwA'
    admin_user.password_confirmation = 'Q&9k4kwTR+4JgjwA'
  end
end
