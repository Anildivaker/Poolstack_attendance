class CreateTimeSheets < ActiveRecord::Migration[5.2]
  def change
    create_table :time_sheets do |t|
      t.date :date 
      t.time :login_time
      t.time :logout_time
      t.references :admin_user

      t.timestamps
    end
  end
end
