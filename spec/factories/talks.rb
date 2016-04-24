FactoryGirl.define do
  factory :talk do
    sequence(:input)  { |n| "Test talk#{n} 45min" }

    initialize_with { new(input) }
  end
end
