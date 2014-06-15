require 'spec_helper'

describe "photos/show" do
  before(:each) do
    @photo = assign(:photo, stub_model(Photo,
      :photo_name => "Photo Name",
      :file_name => "File Name",
      :imageable_id => 1,
      :imageable_type => "Imageable Type"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Photo Name/)
    rendered.should match(/File Name/)
    rendered.should match(/1/)
    rendered.should match(/Imageable Type/)
  end
end
