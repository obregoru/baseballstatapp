require 'spec_helper'

describe "photos/index" do
  before(:each) do
    assign(:photos, [
      stub_model(Photo,
        :photo_name => "Photo Name",
        :file_name => "File Name",
        :imageable_id => 1,
        :imageable_type => "Imageable Type"
      ),
      stub_model(Photo,
        :photo_name => "Photo Name",
        :file_name => "File Name",
        :imageable_id => 1,
        :imageable_type => "Imageable Type"
      )
    ])
  end

  it "renders a list of photos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Photo Name".to_s, :count => 2
    assert_select "tr>td", :text => "File Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Imageable Type".to_s, :count => 2
  end
end
