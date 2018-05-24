require 'rails_helper'

RSpec.describe "repositories/index", type: :view do
  before(:each) do
    assign(:repositories, [
      Repository.create!(
        :name => "Name",
        :description => "Description",
        :url => "Url",
        :user_id => 2
      ),
      Repository.create!(
        :name => "Name",
        :description => "Description",
        :url => "Url",
        :user_id => 2
      )
    ])
  end

  it "renders a list of repositories" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
