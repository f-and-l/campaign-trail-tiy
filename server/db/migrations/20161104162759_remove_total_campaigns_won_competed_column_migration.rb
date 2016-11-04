class RemoveTotalCampaignsWonCompetedColumnMigration < ActiveRecord::Migration[5.0]
  def change
    remove_column :candidates, :total_campaigns_won
    remove_column :candidates, :total_campaigns_competed
  end
end
