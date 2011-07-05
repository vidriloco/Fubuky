#encoding:utf-8
require 'spec_helper'

describe Meta::Rule do
  
  before(:each) do
    @rule = Meta::Rule.new
  end
  
  describe "when feeding a correctly YML formatted survey" do
  
    before(:each) do
      @survey = Meta::Survey.read_from_yml("#{YML_SURVEY_FIXTURES}/valid/tecnologia.yml")               
    end
    
    describe "on a question rules" do
    
      it "should have all it's attributes set and be marked as valid" do
        @rule.assign_attrs(1, @survey.questions[3].rule_list[1])
        @rule.number.should == 1
        @rule.next_question.should == 9
        @rule.condition.should == "one"
        @rule.expected_answers.should == [2]
        @rule.should be_valid
      end
      
    end
    
  end
  
  # Additional specs are covered in superclass Question spec file
  describe "when feeding an incorrectly YML formatted survey" do
    
    before(:each) do
      @survey = Meta::Survey.read_from_yml("#{YML_SURVEY_FIXTURES}/invalid/broken_rules.yml")               
    end
    
    it "should be marked as invalid given it has it's condition field empty" do
      @rule.assign_attrs(1, @survey.questions[0].rule_list[1])
      
      @rule.should_not be_valid
      @rule.errors.should include({ :rule => [I18n.t('rule.yml.validations.condition_not_given')] })
    end
    
    it "should be marked as invalid given it has it's next question field is empty" do
      @rule.assign_attrs(1, @survey.questions[1].rule_list[1])
      
      @rule.should_not be_valid
      @rule.errors.should include({ :rule => [I18n.t('rule.yml.validations.next_question_not_given')] })
    end
    
    it "should be marked as invalid given it has it's expected answers field empty" do
      @rule.assign_attrs(1, @survey.questions[2].rule_list[1])
      
      @rule.should_not be_valid
      @rule.errors.should include({ :rule => [I18n.t('rule.yml.validations.expected_answers_not_given')] })
    end
    
    
  end
  
end