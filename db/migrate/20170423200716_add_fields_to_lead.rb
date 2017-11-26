class AddFieldsToLead < ActiveRecord::Migration[5.0]
  def change
    add_column :leads, :advisor, :string
    add_column :leads, :location, :string
  end
end
