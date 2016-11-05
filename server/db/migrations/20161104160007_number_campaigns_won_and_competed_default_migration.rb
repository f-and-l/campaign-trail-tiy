class NumberCampaignsWonAndCompetedDefaultMigration < ActiveRecord::Migration[5.0]
  def change
    change_column :candidates, :number_campaigns_won, :integer, default: 0
    change_column :candidates, :number_campaigns_competed, :integer, default: 0
  end
end
