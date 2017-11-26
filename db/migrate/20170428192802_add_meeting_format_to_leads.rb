class AddMeetingFormatToLeads < ActiveRecord::Migration[5.0]
  def change
    add_column :leads, :meeting_format, :string
  end
end
