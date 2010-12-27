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
end
