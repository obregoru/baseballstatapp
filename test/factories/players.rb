FactoryGirl.define do
    
  factory :player do |p|
    p.team_id {2 + rand(20)}
    p.first_name  {Faker::Name.first_name}
    p.last_name  {Faker::Name.last_name}
  end
  
end