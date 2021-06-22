class Task < ApplicationRecord
  validates :name, presence: true
  validates :detail, presence: true
end
