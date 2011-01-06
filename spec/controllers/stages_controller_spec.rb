require 'spec_helper'

describe StagesController do
  render_views

  before do
    @position = Position.create(:title => "Ruby developer")
  end

  describe "GET 'new'" do
    it "should be successful" do
      get 'new', :position_id => @position.id
      response.should be_success
    end

    it "assigns @position" do
      get 'new', :position_id => @position.id
      assigns(:position).should be_true
    end
  end

  describe "POST 'create'" do
    it "saves a new stage" do
      post :create, :position_id => @position.id
      @position.reload.stages.count.should == 2
    end

    it "assigns @stage" do
      post :create, :position_id => @position.id
      assigns(:stage).should be_true
    end

    it "redirects to stage number 2 page" do
      pending
      post :create, :position_id => @position.id
    end
  end

  describe "GET 'show'" do
    it "should be successful" do
      get 'show', :position_id => @position.id, :id => 1
      response.should be_success
    end

    it "assigns @stage_index" do
      get 'show', :position_id => @position.id, :id => 1
      assigns(:stage_index).should == 1
    end

    it "assigns @stage_question" do
      get 'show', :position_id => @position.id, :id => 1
      assigns(:stage_question).should be_true
    end
  end
end
