class RemoveTotalPointsColumnCandidateMigration < ActiveRecord::Migration[5.0]
  def change
    remove_column :candidates, :total_avail_points
  end
end
