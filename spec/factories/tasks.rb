FactoryBot.define do
  factory :task do
    name { 'task1' }
    detail { 'test1' }
  end
  factory :second_task, class: Task do
    name { 'task2' }
    detail { 'test2' }
  end
end
