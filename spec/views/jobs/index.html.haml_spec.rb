require 'spec_helper'

describe "jobs/index.html.haml" do

  it "render a table to show all jobs" do
    assign(:jobs, [Job.new(:title => "Ruby developer")])
    render
    rendered.should have_selector("table.records")
  end

  it "should not render a table if there is no job" do
    assign(:jobs, [])
    render
    rendered.should_not have_selector("table.records")
  end
end
