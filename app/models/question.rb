class Question
  include MongoMapper::EmbeddedDocument
  include AggregationFunctions
  
  key :number, Integer
  key :text, String
  key :max_answers, Integer, :default => -1
  key :min_answers, Integer, :default => 1
  many :answers
  many :rules
  
  validate :bulk_field_check
  
  attr_accessor :answer_list, :rule_list, :no_data
  
  def assign_attrs(number, hash)
    return if hash.nil?
    self.number = number
    self.text = hash["text"]
    
    if hash["allowed_answers"]
      self.max_answers &&= hash["allowed_answers"]["max"]
      self.min_answers &&= hash["allowed_answers"]["min"]
    end
    
    self.answer_list = hash["answer_list"]
    aggregate_embedded(:answers)
    
    self.rule_list = hash.has_key?("rule_list") ? hash["rule_list"] : false
    aggregate_embedded(:rules)
  end
  
  def bulk_field_check
    skope="question.yml.validations"
    
    errors.add(:text, I18n.t("#{skope}.text_empty")) if text.blank?  
    errors.add(:answers, I18n.t("#{skope}.answers_not_given")) if answers.blank?   
    errors.add(:rules, I18n.t("#{skope}.rules_not_given")) if rule_list.nil?
  end
end