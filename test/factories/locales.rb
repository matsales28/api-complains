FactoryBot.define do
  factory :locale, class: Locale do
    city { 'Fortaleza' }
    state { 'CE' }
    country { 'Brazil' }
  end
end
