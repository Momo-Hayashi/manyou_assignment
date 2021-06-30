FactoryBot.define do
  factory :user do
    name {'管理者'}
    email { 'admin@example.jp' }
    password { '11111111' }
    password_confirmation { '11111111' }
    admmin { 'Admin' }
  end
end
