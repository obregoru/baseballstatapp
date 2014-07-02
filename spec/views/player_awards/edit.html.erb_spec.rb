require 'spec_helper'

describe "player_awards/edit" do
  before(:each) do
    @player_award = assign(:player_award, stub_model(PlayerAward,
      :league_id => 1,
      :award_year => "MyString",
      :award_name => "MyString",
      :player_id => 1
    ))
  end

  it "renders the edit player_award form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", player_award_path(@player_award), "post" do
      assert_select "input#player_award_league_id[name=?]", "player_award[league_id]"
      assert_select "input#player_award_award_year[name=?]", "player_award[award_year]"
      assert_select "input#player_award_award_name[name=?]", "player_award[award_name]"
      assert_select "input#player_award_player_id[name=?]", "player_award[player_id]"
    end
  end
end
