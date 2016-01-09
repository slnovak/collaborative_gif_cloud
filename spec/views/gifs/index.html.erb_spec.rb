require 'rails_helper'

RSpec.describe "gifs/index", type: :view do
  before(:each) do
    assign(:gifs, [
      GIF.create!(),
      GIF.create!()
    ])
  end

  it "renders a list of gifs" do
    render
  end
end
