FactoryBot.define do
  factory :complain do
    title { Faker::GreekPhilosophers.name }
    description { Faker::GreekPhilosophers.quote }
    company { 'Gocase' }
    locale
  end
end
