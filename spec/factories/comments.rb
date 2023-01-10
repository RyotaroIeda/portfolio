FactoryBot.define do
  factory :comment do
    content { "MyString" }
    user
    sauna
  end
end
