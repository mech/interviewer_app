require 'spec_helper'

describe JobsController do

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
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
  end

  describe "GET 'create'" do
    it "should be successful" do
      get 'create'
      response.should redirect_to(:action => "index")
    end
  end

  describe "GET 'edit'" do
    it "should be successful" do
      get 'edit', :id => 1
      response.should be_success
    end
  end

  describe "GET 'update'" do
    it "should be successful" do
      pending
      get 'update', :id => 1
      response.should be_success
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
