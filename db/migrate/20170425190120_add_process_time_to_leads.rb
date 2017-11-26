class AddProcessTimeToLeads < ActiveRecord::Migration[5.0]
  def change
    add_column :leads, :process_time, :datetime
  end
end
