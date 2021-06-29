class Task < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  validates :detail, presence: true
  enum status: {"---":0, 未着手:1, 着手中:2, 完了:3 }
  enum priority: { 高:0, 中:1, 低:2, "--":3 }

  scope :by_name, -> (name){ where('name LIKE ?', "%#{name}%") }
  scope :by_status, -> (status){ where(status: status) }
end
