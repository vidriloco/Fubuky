class Client
  include Mongoid::Document
  
  field :name, type: String, :unique => true
  validates_uniqueness_of :name
  
  has_many :surveys
  
end