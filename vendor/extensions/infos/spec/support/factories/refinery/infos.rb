
FactoryGirl.define do
  factory :info, :class => Refinery::Infos::Info do
    sequence(:title) { |n| "refinery#{n}" }
  end
end

