require 'spec_helper'

describe "batting_stats/index" do
  before(:each) do
    assign(:batting_stats, [
      stub_model(BattingStat,
        :player_id => 1,
        :legacy_id => "Legacy",
        :at_bats => 2,
        :hits => 3,
        :doubles => 4,
        :triples => 5,
        :home_runs => 6,
        :runs_batted => 7
      ),
      stub_model(BattingStat,
        :player_id => 1,
        :legacy_id => "Legacy",
        :at_bats => 2,
        :hits => 3,
        :doubles => 4,
        :triples => 5,
        :home_runs => 6,
        :runs_batted => 7
      )
    ])
  end

  it "renders a list of batting_stats" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Legacy".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
    assert_select "tr>td", :text => 7.to_s, :count => 2
  end
end
