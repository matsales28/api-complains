locales = [
  {city: 'Fortaleza', state: 'CE', country: 'Brazil'},
  {city: 'Rio de Janeiro', state: 'RJ', country: 'Brazil'},
  {city: 'São Paulo', state: 'SP', country: 'Brazil'}
]
fortal_locale = Locale.create(locales.first)
rio_locale = Locale.create(locales.second)
sp_locale = Locale.create(locales.third)
companies = ['Gocase', 'Atlantico', 'ReclameAqui']

companies.each do |company|
  4.times do
    Complain.create(title: Faker::GreekPhilosophers, description: Faker::GreekPhilosophers, company: company, locale: fortal_locale)
    Complain.create(title: Faker::GreekPhilosophers, description: Faker::GreekPhilosophers, company: company, locale: rio_locale)
    Complain.create(title: Faker::GreekPhilosophers, description: Faker::GreekPhilosophers, company: company, locale: sp_locale)
  end
end

puts 'Seedando'
