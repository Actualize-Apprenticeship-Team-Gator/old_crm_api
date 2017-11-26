class AddIpStateToLeads < ActiveRecord::Migration[5.0]
  def change
    add_column :leads, :ip_state, :string
  end
end
