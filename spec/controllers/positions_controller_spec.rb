require 'spec_helper'

describe PositionsController do
  render_views

  describe "GET 'index'" do

    it "should be successful" do
      get 'index'
      response.should be_success
    end

    it "assigns @positions" do
      get 'index'
      assigns(:positions).should be_empty
    end

    it "positions scoped to user's company"
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

    it "assigns @position" do
      get 'new'
      assigns(:position).should be_true
    end
  end

  describe "POST 'create'" do
    before do
      @valid_params = {
        :position => {
          :title => "Ruby developer",
          :description => "Looking for Ruby ninja",
          :location => "Tampines"
        }
      }
    end

    context "ajax save proceed to add questions" do
      
    end

    context "when the position saves successfully" do
      it "saves a new position" do
        lambda {
          post 'create', @valid_params
        }.should change(Position, :count).by(1)
      end

      it "assigns @position" do
        post 'create', @valid_params
        assigns(:position).should be_true
      end

      it "sets a flash[:notice] message" do
        post 'create', @valid_params
        flash[:notice].should == "Position has been created successfully."
      end

      it "redirects to the new stage page" do
        post 'create', @valid_params
        response.should redirect_to(new_position_stage_path(assigns(:position)))
      end
    end

    context "when the position fails to save" do
      before do
        @invalid_params = @valid_params
        @invalid_params[:position][:title] = nil
      end

      it "does not create a position" do
        lambda {
          post 'create', @invalid_params
        }.should_not change(Position, :count)
      end

      it "assigns @position" do
        post 'create', @invalid_params
        assigns(:position).should_not be_nil
      end

      it "renders the new template" do
        post 'create', @invalid_params
        response.should render_template("new")
      end

      it "show all errors" do
        post 'create', @invalid_params
        assigns(:position).errors.should_not be_empty
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
      response.should redirect_to(positions_path)
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
