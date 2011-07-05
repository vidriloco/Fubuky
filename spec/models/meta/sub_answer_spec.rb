#encoding:utf-8
require 'spec_helper'

describe Meta::SubAnswer do
  
  before(:each) do
    @sub_answer = Meta::SubAnswer.new
  end
  
  describe "when feeding a correctly YML formatted survey" do
  
    before(:each) do
      @survey = Meta::Survey.read_from_yml("#{YML_SURVEY_FIXTURES}/valid/tecnologia.yml")               
    end
    
    describe "on a question answers' subanswers" do
    
      it "should have all it's attributes set and be marked as valid" do
        @sub_answer.assign_attrs(1, @survey.questions[7].sub_answer_list[1])
        @sub_answer.number.should == 1
        @sub_answer.text.should == "Manejo de plugins"
        
        @sub_answer.should be_valid
      end
      
      it "should have all it's attributes set and be marked as valid" do
        @sub_answer.assign_attrs(3, @survey.questions[7].sub_answer_list[3])
        @sub_answer.number.should == 3
        @sub_answer.text.should == "Manejo de Posts"
        
        @sub_answer.should be_valid
      end
      
    end
    
  end
  
  # Additional specs are covered in superclass Question spec file
  describe "when feeding an incorrectly YML formatted survey" do
    
    before(:each) do
      @survey = Meta::Survey.read_from_yml("#{YML_SURVEY_FIXTURES}/invalid/subanswer_no_text.yml")               
    end
    
    it "should be marked as invalid given it does not have it's fields defined" do
      @sub_answer.assign_attrs(1, @survey.questions.first.sub_answer_list[1])
      
      @sub_answer.should_not be_valid
      @sub_answer.errors[:sub_answer].should == [I18n.t('sub_answer.yml.validations.text_not_given'), I18n.t('sub_answer.yml.validations.no_number_given')]
    end
    
  end
  
end