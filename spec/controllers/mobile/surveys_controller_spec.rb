# encoding: utf-8
require 'spec_helper'

describe Mobile::SurveysController do
  
  describe "GET new" do
    
    describe "given a meta-survey is existent" do
    
      before(:each) do
        Client.create(:name => "Heroku")
        @survey = Meta::Survey.read_from_yml("#{YML_SURVEY_FIXTURES}/valid/tecnologia.yml")
        @survey.save
      end
    
      it "should generate a new survey associated with a registered meta-survey" do
        Meta::Survey.should_receive(:new_fillable_survey).with("1")
        get :new, :metum_id => "1"
        response.should render_template('new')
      end
    
      it "assigns the new generated survey to @survey" do
        get :new, :metum_id => "1"
        assigns(:survey).should be_an_instance_of(Survey)
      end
    end
  end
end