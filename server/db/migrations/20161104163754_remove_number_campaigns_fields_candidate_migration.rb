class RemoveNumberCampaignsFieldsCandidateMigration < ActiveRecord::Migration[5.0]
  def change
    remove_column :candidates, :number_campaigns_won
    remove_column :candidates, :number_campaigns_competed
  end
end
