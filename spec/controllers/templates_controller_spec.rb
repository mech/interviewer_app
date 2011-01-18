require 'spec_helper'

describe TemplatesController do
  render_views

  describe "GET 'browse'" do
    it "should be successful" do
      get 'browse'
      response.should be_success
    end

    it "assigns @templates" do
      get 'browse'
      assigns(:templates).should_not be_nil
    end
  end

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end

    it "assigns @templates" do
      get 'index'
      assigns(:templates).should be_empty
    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end

    it "assigns @template" do
      get 'new'
      assigns(:template).should be_true
    end
  end

  describe "POST 'create'" do
    before do
      @valid_params = {
        :template => {
          :name => "Ruby/Rails/Sinatra"
        }
      }
    end

    context "when the template saves successfully" do
      it "saves a new template" do
        lambda {
          post :create, @valid_params
        }.should change(Template, :count).by(1)
      end

      it "assigns @template" do
        post :create, @valid_params
        assigns(:template).should be_true
      end

      it "sets a flash[:notice] message" do
        post 'create', @valid_params
        flash[:notice].should == "Template has been created successfully."
      end

      it "redirects to template page" do
        post 'create', @valid_params
        response.should redirect_to(assigns(:template))
      end
    end

    context "when the template fails to save" do
      before do
        @invalid_params = @valid_params
        @invalid_params[:template][:name] = nil
      end

      it "does not save a template" do
        lambda {
          post :create, @invalid_params
        }.should_not change(Template, :count)
      end

      it "assigns @template" do
        post :create, @invalid_params
        assigns(:template).should_not be_nil
      end

      it "renders the new template" do
        post :create, @invalid_params
        response.should render_template("new")
      end

      it "shows all errors" do
        post :create, @invalid_params
        assigns(:template).errors.should_not be_empty
      end
    end
  end
end
