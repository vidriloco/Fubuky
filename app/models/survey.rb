class Survey
  include MongoMapper::Document
  
  key :name, String
  key :size, Integer
  key :identifies_user, Boolean
  key :client, String
  many :questions
    
  validate :bulk_field_check
  
  attr_accessor :question_list
  
  def self.read_from_yml(filename)
    f=File.open(filename).read
    s=Survey.new 
    s.assign_attrs(Psych.load(f)["survey"])
    s
  end
  
  def assign_attrs(hash)
    hash.each_key { |key| self.send("#{key}=", hash[key]) }
    
    (question_list || {}).each_key do |key|
      q=Question.new
      q.assign_attrs(question_list[key])
      questions << q
    end
  end

  def bulk_field_check
    skope="survey.yml.validations"
    
    errors.add(:name, I18n.t("#{skope}.name_not_given")) if name.blank?  
    errors.add(:client, I18n.t("#{skope}.client_not_given")) if client.blank?   
    errors.add(:questions, I18n.t("#{skope}.questions_not_given")) if questions.empty?
    
    unless client.blank?
      errors.add(:client, I18n.t("#{skope}.client_not_found")) if Client.first(:name => client).nil?   
    end
  end
  
end