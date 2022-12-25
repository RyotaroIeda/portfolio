FactoryBot.define do
  factory :comment do
    content { "MyString" }
    user { nil }
    sauna { nil }
  end
end
