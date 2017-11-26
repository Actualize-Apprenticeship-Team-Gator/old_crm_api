class AddHotToLeads < ActiveRecord::Migration[5.0]
  def change
    add_column :leads, :hot, :boolean, default: true
  end
end
