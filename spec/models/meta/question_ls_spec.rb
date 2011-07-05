#encoding:utf-8
require 'spec_helper'

describe Meta::QuestionLS do
  
  before(:each) do
    @question = Meta::QuestionLS.new
  end
  
  describe "when feeding a correctly YML formatted survey" do
  
    before(:each) do
      @survey = Meta::Survey.read_from_yml("#{YML_SURVEY_FIXTURES}/valid/tecnologia.yml")               
    end
    
    describe "on a simple question" do
    
      it "should have all it's attributes set and be marked as valid" do
        @question.assign_attrs(7, @survey.question_list[7])
        @question.number.should == 7
        @question.text.should == "¿Qué importancia das a diferentes aspectos al momento de elegir una plataforma de publicación de contenidos?"
        @question.max_answers.should == -1
        @question.min_answers.should == 1
        @question.max_subanswers.should == 1
        @question.min_subanswers.should == 1
        @question.answers.length.should == 5
        @question.answers.each { |a| a.should be_a_kind_of(Meta::Answer) }
        @question.sub_answers.length.should == 3
        @question.sub_answers.each { |a| a.should be_a_kind_of(Meta::SubAnswer) }
        @question.should be_valid
      end
      
      it "should have all it's attributes set and be marked as valid" do
        @question.assign_attrs(8, @survey.question_list[8])
        @question.number.should == 8
        @question.text.should == "Selecciona los componentes que consideras son los mejores en cada plataforma de publicación de contenidos"
        @question.max_answers.should == -1
        @question.min_answers.should == 1
        @question.max_subanswers.should == -1
        @question.min_subanswers.should == 1
        @question.answers.length.should == 4
        @question.answers.each { |a| a.should be_a_kind_of(Meta::Answer) }
        @question.sub_answers.length.should == 4
        @question.sub_answers.each { |a| a.should be_a_kind_of(Meta::SubAnswer) }
        @question.should be_valid
      end
      
    end
    
  end
  
  # Additional specs are covered in superclass Question spec file
  describe "when feeding an incorrectly YML formatted survey" do
    
    before(:each) do
      @survey = Meta::Survey.read_from_yml("#{YML_SURVEY_FIXTURES}/invalid/subanswer_missing.yml")               
    end
    
    it "should be marked as invalid given it has a not defined set of subanswers" do
      @question.assign_attrs(1, @survey.question_list[1])
      
      @question.should_not be_valid
      @question.errors.should include({ :subanswers => [I18n.t('question.yml.validations.sub_answers_not_defined')] })
    end
    
  end
  
end