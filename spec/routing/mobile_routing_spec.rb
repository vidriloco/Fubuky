# encoding: utf-8
require "spec_helper"

describe Mobile::SurveysController do
  describe "routing" do

    it "recognizes path /mobile/meta/1/surveys and associates it with #new action" do
      { :get => "/mobile/meta/1/surveys/new" }.should route_to(:controller => "mobile/surveys", :action => "new", :metum_id => "1")
    end
    
  end
end
