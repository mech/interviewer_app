require 'spec_helper'

describe "jobs/index.html.haml" do
  it "render a table to show all jobs" do
    render
    rendered.should have_selector("table")
  end
end
