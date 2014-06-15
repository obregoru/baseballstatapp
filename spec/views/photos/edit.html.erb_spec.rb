require 'spec_helper'

describe "photos/edit" do
  before(:each) do
    @photo = assign(:photo, stub_model(Photo,
      :photo_name => "MyString",
      :file_name => "MyString",
      :imageable_id => 1,
      :imageable_type => "MyString"
    ))
  end

  it "renders the edit photo form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", photo_path(@photo), "post" do
      assert_select "input#photo_photo_name[name=?]", "photo[photo_name]"
      assert_select "input#photo_file_name[name=?]", "photo[file_name]"
      assert_select "input#photo_imageable_id[name=?]", "photo[imageable_id]"
      assert_select "input#photo_imageable_type[name=?]", "photo[imageable_type]"
    end
  end
end
