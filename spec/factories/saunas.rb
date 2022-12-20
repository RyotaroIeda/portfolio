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
    louly_aufgoose { false }
    louly_body { "MyText" }
    rest_space { false }
    rest_body { "MyText" }
    address { "MyString" }
    access { "MyString" }
    tel { 1 }
    price { "MyString" }
  end
end
