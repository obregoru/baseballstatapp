require 'spec_helper'

describe "players/new" do
  before(:each) do
    assign(:player, stub_model(Player,
      :team_id => 1,
      :legacy_id => "MyString",
      :first_name => "MyString",
      :last_name => "MyString"
    ).as_new_record)
  end

  it "renders new player form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", players_path, "post" do
      assert_select "input#player_team_id[name=?]", "player[team_id]"
      assert_select "input#player_legacy_id[name=?]", "player[legacy_id]"
      assert_select "input#player_first_name[name=?]", "player[first_name]"
      assert_select "input#player_last_name[name=?]", "player[last_name]"
    end
  end
end
