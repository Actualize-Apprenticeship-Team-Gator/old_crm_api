class ChangeDateFormatForAppointments < ActiveRecord::Migration[5.0]
  def change
    change_column :leads, :appointment_date, :datetime
  end
end
