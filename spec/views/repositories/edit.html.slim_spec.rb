require 'rails_helper'

RSpec.describe "repositories/edit", type: :view do
  before(:each) do
    @repository = assign(:repository, Repository.create!(
      :name => "MyString",
      :description => "MyString",
      :url => "MyString",
      :user_id => 1
    ))
  end

  it "renders the edit repository form" do
    render

    assert_select "form[action=?][method=?]", repository_path(@repository), "post" do

      assert_select "input[name=?]", "repository[name]"

      assert_select "input[name=?]", "repository[description]"

      assert_select "input[name=?]", "repository[url]"

      assert_select "input[name=?]", "repository[user_id]"
    end
  end
end
