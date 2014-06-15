require 'spec_helper'

describe "batting_stats/new" do
  before(:each) do
    assign(:batting_stat, stub_model(BattingStat,
      :player_id => 1,
      :legacy_id => "MyString",
      :at_bats => 1,
      :hits => 1,
      :doubles => 1,
      :triples => 1,
      :home_runs => 1,
      :runs_batted => 1
    ).as_new_record)
  end

  it "renders new batting_stat form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", batting_stats_path, "post" do
      assert_select "input#batting_stat_player_id[name=?]", "batting_stat[player_id]"
      assert_select "input#batting_stat_legacy_id[name=?]", "batting_stat[legacy_id]"
      assert_select "input#batting_stat_at_bats[name=?]", "batting_stat[at_bats]"
      assert_select "input#batting_stat_hits[name=?]", "batting_stat[hits]"
      assert_select "input#batting_stat_doubles[name=?]", "batting_stat[doubles]"
      assert_select "input#batting_stat_triples[name=?]", "batting_stat[triples]"
      assert_select "input#batting_stat_home_runs[name=?]", "batting_stat[home_runs]"
      assert_select "input#batting_stat_runs_batted[name=?]", "batting_stat[runs_batted]"
    end
  end
end
