class AddNotesToLead < ActiveRecord::Migration[5.0]
  def change
    add_column :leads, :notes, :text
  end
end
