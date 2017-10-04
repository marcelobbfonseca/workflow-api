FactoryGirl.define do
  factory :task, aliases: [:node, :activity] do
    xml_id "My_xml_id"
    category 'task'
    content 'wash the car'
    status 'inactive'

    trait :with_reporter_assignee do
      association :assignee, :reporter
      category 'userTask'
      status 'started'
    end

    trait :start_event do
      category 'startEvent'
    end

    trait :user_event do
      category 'userTask'
    end

    trait :end_event do
      category 'endEvent'
    end

    trait :user_task do
      category 'userTask'
    end

  end
end
