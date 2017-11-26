class CreateDailyProgressLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :daily_progress_logs do |t|
      t.integer :admin_id
      t.date :date
      t.integer :processed, default: 0
      t.integer :connects, default: 0
      t.integer :sets, default: 0

      t.timestamps
    end
  end
end
