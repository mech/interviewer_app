require 'spec_helper'

describe PositionsController do
  render_views

  let(:position) { Position.create(:title => "Ruby developer") }

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
      get 'show', :id => position.id
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

    context "when the position saves successfully" do
      it "saves a new position" do
        lambda {
          xhr :post, 'create', @valid_params
        }.should change(Position, :count).by(1)
      end

      it "assigns @position" do
        xhr :post, 'create', @valid_params
        assigns(:position).should be_true
      end

      it "sets a flash[:notice] message" do
        post 'create', @valid_params
        flash[:notice].should == "Position has been created successfully."
      end

      it "redirects to the new stage page" do
        post 'create', @valid_params
        response.should redirect_to(position_stage_path(assigns(:position), 1))
      end
    end

    context "when the position fails to save" do
      before do
        @invalid_params = @valid_params
        @invalid_params[:position][:title] = nil
      end

      it "does not create a position" do
        lambda {
          xhr :post, 'create', @invalid_params
        }.should_not change(Position, :count)
      end

      it "assigns @position" do
        xhr :post, 'create', @invalid_params
        assigns(:position).should_not be_nil
      end

      it "renders the new template" do
        xhr :post, 'create', @invalid_params
        response.should render_template("shared/_error_messages")
      end

      it "shows all errors" do
        xhr :post, 'create', @invalid_params
        assigns(:position).errors.should_not be_empty
      end
    end
  end

  describe "GET 'edit'" do
    it "should be successful" do
      get 'edit', :id => position.id
      response.should be_success
    end
  end

  describe "POST 'update'" do
    it "should be successful" do
      post 'update', :id => position.id
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
