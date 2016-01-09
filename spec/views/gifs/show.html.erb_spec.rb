require 'rails_helper'

RSpec.describe "gifs/show", type: :view do
  before(:each) do
    @gif = assign(:gif, GIF.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
