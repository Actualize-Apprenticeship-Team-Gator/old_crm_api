class AddNumberOfDialsToLeads < ActiveRecord::Migration[5.0]
  def change
    add_column :leads, :number_of_dials, :integer, default: 0
  end
end
