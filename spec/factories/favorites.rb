FactoryBot.define do
  factory :favorite do
    user_id { 1 }
    sauna_id { 1 }
    user
    sauna
  end
end
