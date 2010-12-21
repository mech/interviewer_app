require 'spec_helper'

describe JobsController do
  render_views

  describe "GET 'index'" do

    it "should be successful" do
      get 'index'
      response.should be_success
    end

    it "assigns @jobs" do
      get 'index'
      assigns(:jobs).should_not be_empty
    end

    it "jobs scoped to user's company"
  end

  describe "GET 'show'" do
    it "should be successful" do
      get 'show', :id => 1
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end

    it "assigns @job" do
      get 'new'
      assigns(:job).should be_true
    end
  end

  describe "POST 'create'" do
    before do
      @valid_params = {
        :job => {
          :title => "Ruby developer",
          :description => "Looking for Ruby ninja",
          :location => "Tampines"
        }
      }
    end

    context "when the job saves successfully" do
      it "saves a new job" do
        lambda {
          post 'create', @valid_params
        }.should change(Job, :count).by(1)
      end

      it "assigns @job" do
        post 'create', @valid_params
        assigns(:job).should be_true
      end

      it "sets a flash[:notice] message" do
        post 'create', @valid_params
        flash[:notice].should == "Job has been created successfully."
      end

      it "redirects to the jobs index page" do
        post 'create', @valid_params
        response.should redirect_to(:action => "index")
      end
    end

    context "when the job fails to save" do
      before do
        @invalid_params = @valid_params
        @invalid_params[:job][:title] = nil
      end

      it "does not create a job" do
        lambda {
          post 'create', @invalid_params
        }.should_not change(Job, :count)
      end

      it "assigns @job" do
        post 'create', @invalid_params
        assigns(:job).should_not be_nil
      end

      it "renders the new template" do
        post 'create', @invalid_params
        response.should render_template("new")
      end

      it "show all errors" do
        post 'create', @invalid_params
        assigns(:job).errors.should_not be_empty
      end
    end
  end

  describe "GET 'edit'" do
    it "should be successful" do
      get 'edit', :id => 1
      response.should be_success
    end
  end

  describe "POST 'update'" do
    it "should be successful" do
      post 'update', :id => 1
      response.should redirect_to(jobs_path)
    end
  end

  describe "GET 'destroy'" do
    it "should be successful" do
      pending
      get 'destroy', :id => 1
      response.should be_success
    end
  end

end
