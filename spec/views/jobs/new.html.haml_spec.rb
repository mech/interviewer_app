require 'spec_helper'

describe "jobs/new.html.haml" do
  let(:job) { Job.new }

  before do
    assign(:job, job)
  end

  it "renders a form to create a job position" do
    render
  end
end
