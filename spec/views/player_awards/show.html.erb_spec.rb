require 'spec_helper'

describe "player_awards/show" do
  before(:each) do
    @player_award = assign(:player_award, stub_model(PlayerAward,
      :league_id => 1,
      :award_year => "Award Year",
      :award_name => "Award Name",
      :player_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Award Year/)
    rendered.should match(/Award Name/)
    rendered.should match(/2/)
  end
end
