class AddDatestampsToCandidatesAndCampaignMigration < ActiveRecord::Migration[5.0]
  def change
    add_column :candidates, :created_at, :datetime
    add_column :candidates, :updated_at, :datetime

    add_column :campaigns, :created_at, :datetime
    add_column :campaigns, :updated_at, :datetime
  end
end
