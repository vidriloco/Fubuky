#encoding:utf-8
require 'spec_helper'

describe Meta::QuestionCS do
  
  describe "when feeding a correctly YML formatted survey" do
  
    before(:each) do
      @survey = Meta::Survey.read_from_yml("#{YML_SURVEY_FIXTURES}/valid/tecnologia.yml")               
    end
    
    describe "on a simple question" do
    
      before(:each) do
        @question = Meta::QuestionCS.new
      end
    
      it "should have all it's attributes set and be marked as valid" do
        @question.assign_attrs(6, @survey.question_list[6])
        @question.number.should == 6
        @question.text.should == "Entre tus conocidos que predominancia de uso tienen las siguientes plataformas de publicación  de contenidos. Suma constante a 100"
        @question.max_answers.should == -1
        @question.min_answers.should == 1
        @question.max_weighing.should == 100
        @question.min_weighing.should == 0
        @question.answers.length.should == 4
        @question.answers.each { |a| a.should be_a_kind_of(Meta::Answer) }
        @question.should be_valid
      end
      
    end
    
  end
  
  # This is covered in a spec on survey's specs and additional specs for superclass Question
  #describe "when feeding an incorrectly YML formatted survey" do
  
end