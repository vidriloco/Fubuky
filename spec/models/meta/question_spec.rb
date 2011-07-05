#encoding:utf-8
require 'spec_helper'

describe Meta::Question do
  
  before(:each) do
    @question = Meta::Question.new
  end
  
  describe "when feeding a correctly YML formatted survey" do
  
    before(:each) do
      @survey = Meta::Survey.read_from_yml("#{YML_SURVEY_FIXTURES}/valid/tecnologia.yml")               
    end
    
    describe "on a simple question" do
    
      it "should have all it's attributes set and be marked as valid" do
        @question.assign_attrs(1, @survey.question_list[1])
        @question.number.should == 1
        @question.text.should == "¿Cuántas horas por semana dedicas a estar conectado a internet?"
        @question.max_answers.should == 1
        @question.min_answers.should == 1
        @question.answers.length.should == 4
        @question.answers.each { |a| a.should be_an_instance_of(Meta::Answer) }
        @question.should be_valid
      end
      
      it "should have all it's attributes set and be marked as valid" do
        @question.assign_attrs(2, @survey.question_list[2])
        @question.number.should == 2
        @question.text.should == "¿Cuál es el motor de búsqueda de tú elección?"
        @question.max_answers.should == 1
        @question.min_answers.should == 1
        @question.answers.length.should == 4
        @question.answers.each { |a| a.should be_an_instance_of(Meta::Answer) }
        @question.should be_valid
      end
      
      it "should have all it's attributes set and be marked as valid" do
        @question.assign_attrs(3, @survey.question_list[3])
        @question.number.should == 3
        @question.text.should == "De la lista siguiente, selecciona las redes sociales en las que estás inscrito"
        @question.max_answers.should == -1
        @question.min_answers.should == 1
        @question.answers.length.should == 5
        @question.answers.each { |a| a.should be_an_instance_of(Meta::Answer) }
        @question.should be_valid
      end
      
      it "should have all it's attributes set and be marked as valid" do
        @question.assign_attrs(4, @survey.question_list[4])
        @question.number.should == 4
        @question.text.should == "¿Cuentas con conocimientos en plataformas para publicación de contenidos tales como Wordpress, Harmony, Joomla, etc?"
        @question.max_answers.should == 1
        @question.min_answers.should == 1
        @question.answers.length.should == 2
        @question.answers.each { |a| a.should be_an_instance_of(Meta::Answer) }
        @question.rules.length.should == 1
        @question.rules.each { |r| r.should be_an_instance_of(Meta::Rule) }
        @question.should be_valid
      end
      
      it "should have all it's attributes set and be marked as valid" do
        @question.assign_attrs(9, @survey.question_list[9])
        @question.number.should == 9
        @question.text.should == "Según tú opinión, el software de código abierto es:"
        @question.max_answers.should == 1
        @question.min_answers.should == 1
        @question.answers.length.should == 5
        @question.answers.each { |a| a.should be_an_instance_of(Meta::Answer) }
        @question.should be_valid
      end
    end
    
  end
  
  describe "when feeding a YML formatted survey which has bad question embedded fields" do
    
    before(:each) do
      
    end
    
  end
  
  describe "when feeding an incorrectly YML formatted survey" do
  
    before(:each) do
      @survey = Meta::Survey.read_from_yml("#{YML_SURVEY_FIXTURES}/invalid/answer_missing.yml")               
    end
    
    describe "on a simple question" do
    
      it "should be marked as non valid given it lacks text content" do
        @question.assign_attrs(1, @survey.question_list[1])
        
        @question.should_not be_valid
        @question.errors.should include({ :text => [I18n.t('question.yml.validations.text_empty')] })
      end
      
      it "should be marked as non valid given it has no answers to choose from" do
        @question.assign_attrs(2, @survey.question_list[2])
        
        @question.should_not be_valid
        @question.errors.should include({ :answers => [I18n.t('question.yml.validations.answers_not_given')] })
      end
      
      it "should be marked as non valid given it has a rules definition section but it's empty" do
        @question.assign_attrs(3, @survey.question_list[3])
        
        @question.should_not be_valid
        @question.errors.should include({ :rules => [I18n.t('question.yml.validations.rules_not_given')] })
      end
      
      it "should be marked as non valid given the question is totally empty" do
        @question.assign_attrs(4, @survey.question_list[4])
        @question.should_not be_valid
        @question.errors.should include({ :text => [I18n.t('question.yml.validations.text_empty')], 
                                          :answers => [I18n.t('question.yml.validations.answers_not_given')] })
      end
    end
    
  end
  
end