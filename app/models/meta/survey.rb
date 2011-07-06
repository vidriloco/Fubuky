class Meta::Survey
  include MongoMapper::Document
  include AggregationFunctions
  
  key :name, String
  key :size, Integer
  key :identifies_user, Boolean
  key :client, String
  many :questions, :class => Meta::Question#, :polymorphic => true
  
  many :surveys
    
  validate :bulk_field_check
  validates_associated :questions, :message => I18n.t("survey.yml.validations.questions_invalid")
  
  attr_accessor :question_list
  
  def self.read_from_yml(filename)
    f=File.open(filename).read
    s=self.new 
    yml=Psych.load(f)
    s.assign_attrs(yml["survey"]) if yml
    s
  end
  
  def self.new_fillable_survey(id)
    Object::Survey.new(:meta_survey => self.find(id))
  end
  
  def assign_attrs(hash)
    return if hash.blank?
    hash.each_key { |key| self.send("#{key}=", hash[key]) }
    aggregate_embedded(:questions)
  end

  def bulk_field_check
    @skope="survey.yml.validations"
    errors.add(:name, I18n.t("#{@skope}.name_not_given")) if name.blank?  
    errors.add(:client, I18n.t("#{@skope}.client_not_given")) if client.blank?   
    errors.add(:questions, I18n.t("#{@skope}.questions_not_given")) if questions.empty?
    
    unless client.blank?
      errors.add(:client, I18n.t("#{@skope}.client_not_found")) if Client.first(:name => client).nil?   
    end
  end
  
end