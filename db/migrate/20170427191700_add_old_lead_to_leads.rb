class AddOldLeadToLeads < ActiveRecord::Migration[5.0]
  def change
    add_column :leads, :old_lead, :boolean, default: false
  end
end
