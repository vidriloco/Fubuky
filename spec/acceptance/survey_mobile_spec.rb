# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')
#include Warden::Test::Helpers

feature "Solving the technology survey example " do
  
  before(:each) do
    Client.create(:name => "Heroku")
    @survey = Meta::Survey.read_from_yml("#{YML_SURVEY_FIXTURES}/valid/tecnologia.yml")
    @survey.save    
  end
  
  describe "given I visit the URL of this particular survey" do
    
    before(:each) do
      visit new_mobile_metum_survey_path(@survey.id)
    end
    
    it "should show me the first question" do
      within(".question") do
        within(".number") do
          page.should have_content("1.")
        end
        within(".text") do
          page.should have_content("¿Cuántas horas por semana dedicas a estar conectado a internet?")
        end
      end
      
      
    end
    
  end
  
end
