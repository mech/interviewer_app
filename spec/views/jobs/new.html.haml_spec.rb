require 'spec_helper'

describe "jobs/new.html.haml" do
  let(:job) { Job.new }

  before do
    assign(:job, job)
  end

  it "renders a form to create a job position" do
    render
    rendered.should have_selector("form") do |form|
      form.should have_selector("input", :type => "submit")
    end
  end
end
