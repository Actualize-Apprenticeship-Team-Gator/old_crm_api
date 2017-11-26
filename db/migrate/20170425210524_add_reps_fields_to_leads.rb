class AddRepsFieldsToLeads < ActiveRecord::Migration[5.0]
  def change
    add_column :leads, :first_appointment_set, :date
    add_column :leads, :first_appointment_actual, :date
    add_column :leads, :first_appointment_format, :string
    add_column :leads, :second_appointment_set, :date
    add_column :leads, :second_appointment_actual, :date
    add_column :leads, :second_appointment_format, :string
    add_column :leads, :enrolled_date, :date
    add_column :leads, :deposit_date, :date
    add_column :leads, :sales, :integer
    add_column :leads, :collected, :integer
    add_column :leads, :status, :string
    add_column :leads, :next_step, :string
    add_column :leads, :rep_notes, :text
  end
end
