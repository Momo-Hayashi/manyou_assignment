FactoryBot.define do
  factory :task do
    name { 'task1' }
    detail { 'test1' }
    expire_on { '002021/08/16' }
    status { '着手中' }
    priority { '中' }
    association :user

    after (:build) do |task|
      label = create(:label)
      label2 = create(:label2)
      task.labellings << build(:labelling, task: task, label: label)
      task.labellings << build(:labelling, task: task, label: label2)      
    end
  end

  factory :second_task, class: Task do
    name { 'task2' }
    detail { 'test2' }
    expire_on { '002021/07/01' }
    status { '完了' }
    priority { '高' }
    association :user

    after (:build) do |task|
      label3 = create(:label3)
      task.labellings << build(:labelling, task: task, label: label3)
    end
  end

  factory :third_task, class: Task do
    name { 'task1' }
    detail { 'test3' }
    expire_on { '002021/07/01' }
    status { '完了' }
    association :user
  end

end
