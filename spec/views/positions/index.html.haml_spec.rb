require 'spec_helper'

describe "positions/index.html.haml" do

  it "render a table to show all positions" do
    assign(:positions, [Position.new(:title => "Ruby developer")])
    render
    rendered.should have_selector("table.records")
  end

  it "should not render a table if there is no position" do
    assign(:positions, [])
    render
    rendered.should_not have_selector("table.records")
  end
end
