class AddIsPresentToTimeSheet < ActiveRecord::Migration[5.2]
  def change
    add_column :time_sheets, :is_present, :boolean, default: false
  end
end
