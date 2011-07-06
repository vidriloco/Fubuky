class Survey
  include MongoMapper::Document
  
  belongs_to :meta_survey, :class => Meta::Survey
end