require 'spec_helper'

describe "teams/show" do
  before(:each) do
    @team = assign(:team, stub_model(Team,
      :league_id => 1,
      :team_name => "Team Name",
      :owner_name => "Owner Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Team Name/)
    rendered.should match(/Owner Name/)
  end
end
