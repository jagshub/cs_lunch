FactoryBot.define do
  factory :employee do
    name { Faker::Name.first_name }
    image_url {Faker::Avatar.image }
    department { Department.all.sample }
  end

  factory :department do
    name { Faker::Name.unique.name}
  end
end