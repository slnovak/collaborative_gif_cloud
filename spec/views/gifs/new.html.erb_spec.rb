require 'rails_helper'

RSpec.describe "gifs/new", type: :view do
  before(:each) do
    assign(:gif, GIF.new())
  end

  it "renders new gif form" do
    render

    assert_select "form[action=?][method=?]", gifs_path, "post" do
    end
  end
end
