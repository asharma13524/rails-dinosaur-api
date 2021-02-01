class Cage < ApplicationRecord
  scope :filter_by_cage_status, -> (cage_status) { where cage_status: cage_status }
  has_many :dinosaurs
end
