class Meta::Survey
  include Mongoid::Document
  include AggregationFunctions
  
  cattr_reader :skope
  @@skope = "survey.yml.validations"
  
  field :name, type: String
  field :size, type: Integer
  field :identifies_user, type: Boolean
  
  embeds_many :questions, :class_name => "Meta::Question"
  
  belongs_to :client

  validates_presence_of :client, :message => I18n.t("#{@@skope}.client_not_found_or_not_given")
  validates_presence_of :questions, :message => I18n.t("#{@@skope}.questions_not_given")
  validates_presence_of :name, :message => I18n.t("#{@@skope}.name_not_given")
  validates_associated :questions, :message => I18n.t("#{@@skope}.malformed_questions_provided")
  
  attr_accessor :question_list, :client_name
  
  def self.read_from_yml(filename)
    f=File.open(filename).read
    s=self.new 
    yml=Psych.load(f)
    s.assign_attrs(yml["survey"]) if yml
    s
  end
  
  def assign_attrs(hash)
    return if hash.blank?
    hash.each_key { |key| self.send("#{key}=", hash[key]) }
    self.client = Client.where(name: client_name).first
    aggregate_embedded(:questions)
  end
  
end