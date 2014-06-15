require 'spec_helper'

describe "batting_stats/show" do
  before(:each) do
    @batting_stat = assign(:batting_stat, stub_model(BattingStat,
      :player_id => 1,
      :legacy_id => "Legacy",
      :at_bats => 2,
      :hits => 3,
      :doubles => 4,
      :triples => 5,
      :home_runs => 6,
      :runs_batted => 7
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Legacy/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/4/)
    rendered.should match(/5/)
    rendered.should match(/6/)
    rendered.should match(/7/)
  end
end
