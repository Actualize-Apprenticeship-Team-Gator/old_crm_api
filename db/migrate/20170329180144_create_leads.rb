class CreateLeads < ActiveRecord::Migration[5.0]
  def change
    create_table :leads do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :ip
      t.string :city
      t.string :state
      t.string :zip
      t.boolean :contacted, default: false
      t.date :appointment_date

      t.timestamps
    end
  end
end
