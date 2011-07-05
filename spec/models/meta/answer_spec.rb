#encoding:utf-8
require 'spec_helper'

describe Meta::Answer do
  
  before(:each) do
    @answer = Meta::Answer.new
  end
  
  describe "when feeding a correctly YML formatted survey" do
  
    before(:each) do
      @survey = Meta::Survey.read_from_yml("#{YML_SURVEY_FIXTURES}/valid/tecnologia.yml")               
    end
    
    describe "on a question set of answers" do
    
      it "should have all it's attributes set and be marked as valid" do
        @answer.assign_attrs(1, @survey.questions.first.answer_list[1])
        @answer.number.should == 1
        @answer.text.should == "Menos de 5 horas"
        @answer.style.should == "Closed"
        
        @answer.should be_valid
      end
      
      it "should have all it's attributes set and be marked as valid" do
        @answer.assign_attrs(4, @survey.questions[1].answer_list[4])
        @answer.number.should == 4
        @answer.text.should == "Otro"
        @answer.style.should == "Open"
       
        @answer.should be_valid
      end
      
    end
    
  end
  
  # Additional specs are covered in superclass Question spec file
  describe "when feeding an incorrectly YML formatted survey" do
    
    before(:each) do
      @survey = Meta::Survey.read_from_yml("#{YML_SURVEY_FIXTURES}/invalid/answer_no_text.yml")               
    end
    
    it "should be marked as invalid given it does not have it's fields defined" do
      @answer.assign_attrs(1, @survey.questions.first.answer_list[1])
      
      @answer.should_not be_valid
      @answer.errors.should include({ :answer => [I18n.t('answer.yml.validations.empty')] })
    end
    
  end
  
end