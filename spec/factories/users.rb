FactoryBot.define do
  factory :user do
    name { "タロウ" }
    email { |n| "testuser#{n}@user.com" }
    password { "111111" }
    password_confirmation { "111111" }
    homesauna { "かるまる" }
    introduce { "よろしくお願いします" }
  end
end
