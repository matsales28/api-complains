FactoryBot.define do
  factory :complain, class: Complain do
    title { Faker::GreekPhilosophers.name }
    description { Faker::GreekPhilosophers.quote }
    company { 'Gocase' }
    locale
  end
end
