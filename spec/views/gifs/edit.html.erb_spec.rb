require 'rails_helper'

RSpec.describe "gifs/edit", type: :view do
  before(:each) do
    @gif = assign(:gif, GIF.create!())
  end

  it "renders the edit gif form" do
    render

    assert_select "form[action=?][method=?]", gif_path(@gif), "post" do
    end
  end
end
