require 'spork'

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However, 
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.
  # This file is copied to spec/ when you run 'rails generate rspec:install'
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'capybara/rspec'
  require 'mongoid'
  
  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
  
  YML_SURVEY_FIXTURES = "#{Rails.root}/spec/resources/surveys"
  
  RSpec.configure do |config|
    # == Mock Framework
    #
    # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
    #
    # config.mock_with :mocha
    # config.mock_with :flexmock
    # config.mock_with :rr
    config.mock_with :rspec
    
    
    config.before(:each) do
      DatabaseCleaner.orm = "mongoid" 
      DatabaseCleaner.strategy = :truncation
      DatabaseCleaner.clean
    end
    
    Capybara.javascript_driver = :selenium
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, :browser => :firefox)
    end
    Capybara.ignore_hidden_elements = true
  end
end

Spork.each_run do
  # This code will be run each time you run your specs.
  # reload factories
  load "#{Rails.root}/config/routes.rb" 
  
  Dir["#{Rails.root}/app/**/*.rb"].each { |f| load f }
  #Factory.factories.clear
  #Factory.definition_file_paths = Dir[File.join(Rails.root, "spec", "factories")]
  #Factory.find_definitions.each do |location|
  #  Dir["#{location}/**/*.rb"].each { |file| load file }
  #end
end