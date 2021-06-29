class User < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  has_secure_password
  has_many :tasks, dependent: :destroy

  after_destroy :admin_necessary
  after_update :admin_necessary

  def admin_necessary
    if User.where(admin: 'true').count == 0
      raise ActiveRecord::Rollback
    end
  end

  # before_update do
  #   @admin_users = User.where(admin: true)
  #   if (@admin_users.count == 1 && @admin_users.first == self) && !(self.admin)
  #     throw(:abort)
  #   end
  # end
  #
  # ↓だと管理者一人の時、ユーザー情報更新できない
  # before_update do
  # throw(:abort) if User.where(admin: true).count == 1 && self.admin == false
  # end
  #
  # before_destroy do
  #   throw(:abort) if User.where(admin: true).count == 1 && self.admin == true
  # end

end
