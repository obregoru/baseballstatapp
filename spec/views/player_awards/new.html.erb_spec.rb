require 'spec_helper'

describe "player_awards/new" do
  before(:each) do
    assign(:player_award, stub_model(PlayerAward,
      :league_id => 1,
      :award_year => "MyString",
      :award_name => "MyString",
      :player_id => 1
    ).as_new_record)
  end

  it "renders new player_award form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", player_awards_path, "post" do
      assert_select "input#player_award_league_id[name=?]", "player_award[league_id]"
      assert_select "input#player_award_award_year[name=?]", "player_award[award_year]"
      assert_select "input#player_award_award_name[name=?]", "player_award[award_name]"
      assert_select "input#player_award_player_id[name=?]", "player_award[player_id]"
    end
  end
end
