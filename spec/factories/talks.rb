FactoryGirl.define do
  factory :talk do
    sequence(:title)  { |n| "Test talk#{n}" }
    sequence(:tag)    { |n| "tag#{n}" }
    length    { rand(100) }
  end
end
