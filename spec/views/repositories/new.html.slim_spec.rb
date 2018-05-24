require 'rails_helper'

RSpec.describe "repositories/new", type: :view do
  before(:each) do
    assign(:repository, Repository.new(
      :name => "MyString",
      :description => "MyString",
      :url => "MyString",
      :user_id => 1
    ))
  end

  it "renders new repository form" do
    render

    assert_select "form[action=?][method=?]", repositories_path, "post" do

      assert_select "input[name=?]", "repository[name]"

      assert_select "input[name=?]", "repository[description]"

      assert_select "input[name=?]", "repository[url]"

      assert_select "input[name=?]", "repository[user_id]"
    end
  end
end
