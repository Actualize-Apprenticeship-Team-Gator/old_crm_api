class AddExcludeFromCallingToLeads < ActiveRecord::Migration[5.0]
  def change
    add_column :leads, :exclude_from_calling, :boolean, default: false
  end
end
