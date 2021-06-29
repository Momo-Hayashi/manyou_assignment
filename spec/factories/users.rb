FactoryBot.define do
  factory :user do
    name {'一般ユーザー'}
    email { 'user@user.com' }
    password { '11111111' }
    password_confirmation { '11111111' }
    admin { 'false' }
  end

  factory :admin, class: User do
    name {'管理者'}
    email { 'admin@admin.com' }
    password { '11111111' }
    password_confirmation { '11111111' }
    admin { 'true' }
  end
end
