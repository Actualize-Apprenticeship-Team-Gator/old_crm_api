class AddMeeetingTypeToLeads < ActiveRecord::Migration[5.0]
  def change
    add_column :leads, :meeting_type, :string
  end
end
