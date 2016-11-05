class CampaignDateDefaultValueMigration < ActiveRecord::Migration[5.0]
  def change
    change_column :campaigns, :start_date, :datetime, default: Date.today
  end
end
