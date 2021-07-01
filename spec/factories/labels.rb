FactoryBot.define do
  factory :label do
    label_name { 'Hobby' }
  end

  factory :label2, class: Label do
    label_name { 'Work' }
  end

  factory :label3, class: Label do
    label_name { 'Family' }
  end

end
