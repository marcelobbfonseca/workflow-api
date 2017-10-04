FactoryGirl.define do
  factory :user, aliases: [:assignee] do
    name "Peter Parker"
    email 'mrparker@parker.com'
    password 'verysecret'
    role 'api_consumer'

    trait :reporter do
      role 'reporter'
    end

    trait :admin do
      role 'admin'
    end

    trait :chief_editor do
      role 'chief_editor'
    end

  end
end
