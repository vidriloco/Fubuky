#encoding:utf-8
require 'spec_helper'

describe Meta::Survey do
    
  describe "when feeding a YML formatted" do
  
    describe "given no client is registered" do
      before(:each) do
        @survey = Meta::Survey.read_from_yml("#{YML_SURVEY_FIXTURES}/valid/tecnologia.yml")
      end
  
      it "should not be marked as valid given there are no clients registered" do
        @survey.should_not be_valid
        @survey.errors.should == { :client => [I18n.t("survey.yml.validations.client_not_found_or_not_given")] }
      end
    end
  
  
    describe "given a client is registered" do
      
      before(:each) do
        @client = Client.create(:name => "Heroku")
      end
      
      describe "and a correct survey" do
        before(:each) do
          @survey = Meta::Survey.read_from_yml("#{YML_SURVEY_FIXTURES}/valid/tecnologia.yml")
          @s_name = "Uso de tecnologías web"
          @s_size = 200
          @s_identifies_user = false
          @s_client = "Heroku"
          @s_question_number = 9
        end
      
        it "should have all it's attributes set and be marked as valid" do
          @survey.name.should == @s_name
          @survey.size.should == @s_size
          @survey.identifies_user.should == @s_identifies_user
          @survey.client_name.should == @s_client
          @survey.questions.length.should == @s_question_number
          @survey.questions.map { |q| q.should be_a_kind_of(Meta::Question) } 
          @survey.should be_valid
        end
        
        it "should save it's embedded fields when send save message" do
          @survey.save
          saved_survey = Meta::Survey.first
          saved_survey.questions.length.should == @s_question_number
          # simple question Meta::Question
          saved_survey.questions.first.should be_an_instance_of(Meta::Question)
          saved_survey.questions.first.answers.length.should == 4 
          saved_survey.questions.first.answers.last.text.should == "20 horas o más"
          # simple question with rules 
          saved_survey.questions[3].should be_an_instance_of(Meta::Question)
          saved_survey.questions[3].answers.length.should == 2
          saved_survey.questions[3].answers.first.text.should == "Si"
          saved_survey.questions[3].rules.length.should == 1
          rule=saved_survey.questions[3].rules.first
          rule.next_question.should == 9
          rule.expected_answers.should == [2]
          rule.condition.should == "one"
          # checking classes
          saved_survey.questions[4].should be_an_instance_of(Meta::QuestionP)
          saved_survey.questions[5].should be_an_instance_of(Meta::QuestionCS)
          # likert-scale question Meta::QuestionLS
          saved_survey.questions[6].should be_an_instance_of(Meta::QuestionLS)
          saved_survey.questions[6].answers.length.should == 5
          saved_survey.questions[6].answers.first.text.should == "Tamaño de la Comunidad"
          saved_survey.questions[6].sub_answers.length.should == 3
          saved_survey.questions[6].sub_answers.first.text.should == "Mucho"
        end
      end
    end
    
    describe "non-valid survey with missing fields" do
      before(:each) do
        @survey = Meta::Survey.read_from_yml("#{YML_SURVEY_FIXTURES}/invalid/questions_name_client_missing.yml")
      end
      
      it "should not be marked as valid given it lacks a name" do
        @survey.should_not be_valid
        @survey.errors.should include({ :name => [I18n.t('survey.yml.validations.name_not_given')] })
      end
      
      it "should not be marked as valid given it lacks a client name" do
        @survey.should_not be_valid
        @survey.errors.should include({ :client => [I18n.t('survey.yml.validations.client_not_found_or_not_given')] })
      end
      
      it "should not be marked as valid given it lacks questions" do
        @survey.should_not be_valid
        @survey.errors.should include({ :questions => [I18n.t('survey.yml.validations.questions_not_given')] })
      end
      
    end
    
    describe "non-valid survey with no content" do
      
      before(:each) do
        @survey = Meta::Survey.read_from_yml("#{YML_SURVEY_FIXTURES}/invalid/survey_empty.yml")
      end
      
      it "should not be marked as valid given it is totally empty" do
        @survey.should_not be_valid
        @survey.errors.should include({ :questions => [I18n.t('survey.yml.validations.questions_not_given')],
                                        :client => [I18n.t('survey.yml.validations.client_not_found_or_not_given')],
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