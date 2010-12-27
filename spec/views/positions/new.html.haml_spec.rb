require 'spec_helper'

describe "positions/new.html.haml" do
  let(:position) { Position.new }

  before do
    assign(:position, position)
  end

  it "renders a form to create a new position" do
    render
    rendered.should have_selector("form", :method => "post", :action => positions_path) do |form|
      form.should have_selector("input", :type => "submit")
    end
  end
end
