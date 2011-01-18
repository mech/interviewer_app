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

    it "assigns @stage" do
      get 'new', :position_id => @position.id
      assigns(:stage).should be_true
    end
  end

  describe "POST 'create'" do
    it "saves a new stage" do
      expect {
        post :create, :position_id => @position.id
      }.to change {
        @position.reload.stages.count
      }.by(1)
    end

    it "assigns @stage" do
      post :create, :position_id => @position.id
      assigns(:stage).should be_true
    end

    it "redirects to stage number 2 page" do
      post :create, :position_id => @position.id
      response.should redirect_to [@position, assigns(:stage)]
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

  describe "POST 'save_as_templates'" do
    it "assigns @template" do
      xhr :post, "save_as_templates", :position_id => @position.id, :id => @position.stage_at(1).stage_number, :template => {:name => "Untitled"}
      assigns(:template).should be_true
    end

    it "saves a new template" do
      expect {
        xhr :post, "save_as_templates", :position_id => @position.id, :id => @position.stage_at(1).stage_number, :template => {:name => "Untitled"}
      }.to change {
        Template.count
      }.by(1)
    end
  end

  describe "POST 'pinned'" do
    it "assigns @pin_stage" do
      xhr :post, 'pinned', :position_id => @position.id, :id => @position.stage_at(1).stage_number, :stage_number => @position.stage_at(1).stage_number
      assigns(:pin_stage).should_not be_nil
    end

    it "saves a new pin stage" do
      expect {
        xhr :post, 'pinned', :position_id => @position.id, :id => @position.stage_at(1).stage_number, :stage_number => @position.stage_at(1).stage_number
      }.to change {
        PinStage.count
      }.by(1)
    end
  end

  describe "POST 'pull_questions'" do
    before do
      @template = Template.create(:name => "Mid-level Project Manager")
      @pin_stage = PinStage.create(:position_id => @position.id, :stage_number => @position.stage_at(1).stage_number)
      2.times do
        @template.questions << Question.new(:category => "Direct", :question => "test", :answer => "test", :points => 10)
      end
      @template.save
    end

    it "saves all questions from template to the stage" do
      expect {
        xhr :post, 'pull_questions', :position_id => @position.id, :id => @position.stage_at(1).stage_number, :pin_stage_id => @pin_stage.id, :template_id => @template.id
      }.to change {
        @position.reload.stage_at(@pin_stage.stage_number).stage_questions.count
      }.by(2)
    end
  end
end
