#encoding:utf-8
require 'spec_helper'

describe Meta::QuestionP do
  
  describe "when feeding a correctly YML formatted survey" do
  
    before(:each) do
      @survey = Meta::Survey.read_from_yml("#{YML_SURVEY_FIXTURES}/valid/tecnologia.yml")               
    end
    
    describe "on a simple question" do
    
      before(:each) do
        @question = Meta::QuestionP.new
      end
    
      it "should have all it's attributes set and be marked as valid" do
        @question.assign_attrs(5, @survey.question_list[5])
        @question.number.should == 5
        @question.text.should == "Ordena del 1 al 4 la plataforma de contenidos que consideres es la más completa"
        @question.max_answers.should == -1
        @question.min_answers.should == 1
        @question.max_weighing.should == 4
        @question.min_weighing.should == 1
        @question.answers.length.should == 4
        @question.answers.each { |a| a.should be_a_kind_of(Meta::Answer) }
        @question.should be_valid
      end
      
    end
    
  end
  
  # This is covered in a spec on survey's specs
  #describe "when feeding an incorrectly YML formatted survey" do
  
end