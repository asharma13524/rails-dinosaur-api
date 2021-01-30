class Dinosaur < ApplicationRecord
  validates :name, presence: true
  validates :species, presence: true
  validates :diet, presence: true
end
