class AddStandardPhoneToLead < ActiveRecord::Migration[5.0]
  def change
    add_column :leads, :standard_phone, :string
  end
end
