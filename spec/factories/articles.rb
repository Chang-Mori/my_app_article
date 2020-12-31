FactoryBot.define do
  factory :article do
    title {Faker::Lorem.sentence}
    text {Faker::Lorem.sentence}
    genre_id {2}
    association :user
  end
end
