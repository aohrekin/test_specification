FactoryBot.define do
  factory :user do
    name { 'Ivan' }
    patronymic { 'Ivanovich' }
    email { 'ivanovich@example.com' }
    age { '44' }
    country { 'Russia' }
    gender { 'male' }
    surname { 'Ivanov' }
    nationality { 'Russian' }
  end
end
