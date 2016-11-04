class CreateCandidatesTableMigration < ActiveRecord::Migration[5.0]
  def change
    create_table :candidates do |t|
      t.string :name
      t.string :image_url
      t.integer :number_campaigns_won
      t.integer :number_campaigns_competed
      t.integer :intelligence
      t.integer :willpower
      t.integer :charisma
    end

    create_table :campaigns do |t|
      t.datetime :start_date
      t.integer :winner_id
    end

    create_join_table :candidates, :campaigns
  end
end
