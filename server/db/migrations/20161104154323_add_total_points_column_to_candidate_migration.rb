class AddTotalPointsColumnToCandidateMigration < ActiveRecord::Migration[5.0]
  def change
    add_column :candidates, :total_avail_points, :integer, default: 10
  end
end
