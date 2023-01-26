FactoryBot.define do
  factory :sauna do
    name { "MyString" }
    user_id { 1 }
    image_id { "MyString" }
    water_temperature { 1 }
    open_time { "2022-12-11 09:06:40" }
    close_time { "2022-12-11 09:06:40" }
    sauna_temperature { 1 }
    sauna_capacity { 1 }
    water_capacity { 1 }
    sauna_body { "MyText" }
    water_body { "MyText" }
    louly_aufgoose { true }
    louly_body { "MyText" }
    rest_space { true }
    rest_body { "MyText" }
    address { "MyString" }
    access { "MyString" }
    tel { "000-0000-0000" }
    price { "MyString" }
    privacy { "1" }
    http { "aaaa" }
    user
    trait :invalid do
      name { '' }
      privacy { '' }
      user_id { 1 }
    end
  end
end
