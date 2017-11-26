class AddOnlineToLeads < ActiveRecord::Migration[5.0]
  def change
    add_column :leads, :online, :boolean, default: false
  end
end
