class Dinosaur < ApplicationRecord
  scope :filter_by_species, -> (species) { where species: species }
  validates :name, presence: true
  validates :species, presence: true
  validates :diet, presence: true

  belongs_to :cage
end
