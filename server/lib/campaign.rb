
class Campaign < ActiveRecord::Base
  has_and_belongs_to_many :candidates
  belongs_to :winner, class_name: "Candidate", foreign_key: :winner_id
  validates :start_date, presence: true

  def charisma_points_hash
    results_hash = {}
    self.candidates.each do |candidate|
      results_hash[candidate.id] = candidate.charisma
    end
    results_hash
  end

  def intelligence_points_hash
    results_hash = {}
    self.candidates.each do |candidate|
      results_hash[candidate.id] = candidate.intelligence
    end
    results_hash
  end

  def willpower_points_hash
    results_hash = {}
    self.candidates.each do |candidate|
      results_hash[candidate.id] = candidate.willpower
    end
    results_hash
  end

  def charisma_winner_id
    charisma_points_hash.max_by { |k, v| v }[0]
  end

  def intelligence_winner_id
    intelligence_points_hash.max_by { |k, v| v }[0]
  end

  def willpower_winner_id
    willpower_points_hash.max_by { |k, v| v }[0]
  end

  def assign_winner!
    array = [charisma_winner_id, intelligence_winner_id, willpower_winner_id]
    winning_id = array.max_by { |i| array.count(i) }
    self.update!(winner: Candidate.find(winning_id))
    self.save!
  end

end
