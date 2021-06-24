class Task < ApplicationRecord
  validates :name, presence: true
  validates :detail, presence: true
  enum status: {"---":0, 未着手:1, 着手中:2, 完了:3 } 
end
