class Task < ApplicationRecord
  validates :name, presence: true
  validates :detail, presence: true

  enum status: {"---":0, 未着手:1, 着手中:2, 完了:3 }
  enum priority: { 高:0, 中:1, 低:2, "--":3 }

  scope :by_created, -> { order(created_at: :desc) }
  scope :by_expired, -> { order(expire_on: :desc) }
  scope :by_priority, -> { order(priority: :asc) }
  scope :by_name, -> (name){ where('name LIKE ?', "%#{name}%") }
  scope :by_status, -> (status){ where(status: status) }
  scope :by_label, -> (label){ joins(:labellings).where(labellings: { label_id: label }) }

  belongs_to :user
  has_many :labellings, dependent: :destroy
  has_many :labels, through: :labellings
end
