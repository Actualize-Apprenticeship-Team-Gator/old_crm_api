class AddBadNumberToLeads < ActiveRecord::Migration[5.0]
  def change
    add_column :leads, :bad_number, :boolean, default: false
  end
end
