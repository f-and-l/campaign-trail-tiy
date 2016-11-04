class PointsValidator < ActiveModel::Validator
  def validate(record)
    if record.willpower + record.charisma + record.intelligence > record.total_available_points
      record.errors[:total_assigned] << "Can't exceed #{record.total_available_points} points"
    end
  end
end
