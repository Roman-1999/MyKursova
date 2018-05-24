require 'rails_helper'

RSpec.describe "repositories/show", type: :view do
  before(:each) do
    @repository = assign(:repository, Repository.create!(
      :name => "Name",
      :description => "Description",
      :url => "Url",
      :user_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/Url/)
    expect(rendered).to match(/2/)
  end
end
