FactoryGirl.define do
  factory :team do |t|
    sequence(:id) {|n| n + 2}
    t.league_id {1 + rand(2)}
    t.team_name {Faker::Company.name}
    t.owner_name  {Faker::Name.first_name + ' ' + Faker::Name.last_name}
  end
  

end
