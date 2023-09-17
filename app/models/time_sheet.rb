class TimeSheet < ApplicationRecord
  belongs_to :admin_user
  
  validates :date, uniqueness: {scope: :admin_user_id}
end
