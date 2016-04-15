FactoryGirl.define do
  factory :talk do
    sequence(:title)  { |n| "Test talk#{n}" }
    sequence(:tag)    { |n| "tag#{n}" }
    sequence(:length) { rand(100) }
    time_unit "min"
    marked    false
  end
end
