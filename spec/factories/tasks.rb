FactoryBot.define do
  factory :task do
    name { 'task1' }
    detail { 'test1' }
    expire_on { '002021/08/16' }
    status { '着手中' }
  end
  factory :second_task, class: Task do
    name { 'task2' }
    detail { 'test2' }
    expire_on { '002021/07/01' }
    status { '完了' }
  end
end
