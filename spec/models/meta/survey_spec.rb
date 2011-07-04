#encoding:utf-8
require 'spec_helper'

describe Meta::Survey do
  
  describe "when feeding a YML formatted" do
  
    describe "correct survey" do
      before(:each) do
        @survey = Meta::Survey.read_from_yml("#{YML_SURVEY_FIXTURES}/valid/tecnologia.yml")
         @s_name = "Uso de tecnologías web"
         @s_size = 200
         @s_identifies_user = false
         @s_client = "Heroku"
         @s_question_number = 9
      end
  
      it "should not be marked as valid given there are no clients registered" do
        @survey.should_not be_valid
        @survey.errors.should == { :client => [I18n.t('survey.yml.validations.client_not_found')] }
      end
    
      describe "and given the client owning the survey is registered" do
      
        before(:each) do
           Client.new(:name => "Heroku").save
        end
      
        it "should have all it's attributes set and be marked as valid" do
          @survey.name.should == @s_name
          @survey.size.should == @s_size
          @survey.identifies_user.should == @s_identifies_user
          @survey.client.should == @s_client
          @survey.questions.length.should == @s_question_number
          @survey.questions.map { |q| q.should be_a_kind_of(Meta::Question) } 
          @survey.should be_valid
        end
      
      end
    end
    
    describe "non-valid survey with missing fields" do
      before(:each) do
        @survey = Meta::Survey.read_from_yml("#{YML_SURVEY_FIXTURES}/invalid/data_or_questions_missing.yml")
        Client.new(:name => "Heroku").save
      end
      
      it "should not be marked as valid given it lacks a name" do
        @survey.should_not be_valid
        @survey.errors.should include({ :name => [I18n.t('survey.yml.validations.name_not_given')] })
      end
      
      it "should not be marked as valid given it lacks a client name" do
        @survey.should_not be_valid
        @survey.errors.should include({ :client => [I18n.t('survey.yml.validations.client_not_given')] })
      end
      
      it "should not be marked as valid given it lacks questions" do
        @survey.should_not be_valid
        @survey.errors.should include({ :questions => [I18n.t('survey.yml.validations.questions_not_given')] })
      end
      
    end
    
    describe "non-valid survey with no content" do
      
      before(:each) do
        @survey = Meta::Survey.read_from_yml("#{YML_SURVEY_FIXTURES}/invalid/empty_survey.yml")
      end
      
      it "should not be marked as valid given it is totally empty" do
        @survey.should_not be_valid
        @survey.errors.should include({ :questions => [I18n.t('survey.yml.validations.questions_not_given')],
                                        :client => [I18n.t('survey.yml.validations.client_not_given')],
                                        :name => [I18n.t('survey.yml.validations.name_not_given')] })
      end
    end
    
    describe "non-valid survey with a bad klass question type declaration" do

      before(:each) do
        @survey = Meta::Survey.read_from_yml("#{YML_SURVEY_FIXTURES}/invalid/bad_klass.yml")               
      end

      it "should be marked as non valid given it has a bad klass declaration" do
        @survey.should_not be_valid
        @survey.errors.should include({ :questions => [I18n.t('survey.yml.validations.questions_not_given')] })
      end

    end
    
  end
  
end