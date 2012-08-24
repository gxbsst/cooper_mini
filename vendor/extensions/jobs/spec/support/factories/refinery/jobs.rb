
FactoryGirl.define do
  factory :job, :class => Refinery::Jobs::Job do
    sequence(:title) { |n| "refinery#{n}" }
  end
end

