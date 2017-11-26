class AddConnectedToLeads < ActiveRecord::Migration[5.0]
  def change
    add_column :leads, :connected, :boolean, default: false
  end
end
