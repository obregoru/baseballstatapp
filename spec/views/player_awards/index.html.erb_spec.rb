require 'spec_helper'

describe "player_awards/index" do
  before(:each) do
    assign(:player_awards, [
      stub_model(PlayerAward,
        :league_id => 1,
        :award_year => "Award Year",
        :award_name => "Award Name",
        :player_id => 2
      ),
      stub_model(PlayerAward,
        :league_id => 1,
        :award_year => "Award Year",
        :award_name => "Award Name",
        :player_id => 2
      )
    ])
  end

  it "renders a list of player_awards" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Award Year".to_s, :count => 2
    assert_select "tr>td", :text => "Award Name".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
