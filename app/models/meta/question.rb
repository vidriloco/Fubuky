class Meta::Question
  include Mongoid::Document  
  include AggregationFunctions
  
  field :number, type: Integer
  field :text, type: String
  field :max_answers, type: Integer, default: -> { -1 }
  field :min_answers, type: Integer, default: -> { 1 }
  embeds_many :answers, :class_name => "Meta::Answer"
  embeds_many :rules, :class_name => "Meta::Rule"
  
  embedded_in :survey
  
  validate :bulk_field_check
  validates_associated :answers, :message => I18n.t("question.yml.validations.answers_invalid")
  validates_associated :rules, :message => I18n.t("question.yml.validations.rules_invalid")
  
  attr_accessor :answer_list, :rule_list, :no_data
  
  def assign_attrs(number, hash)
    return if hash.nil?
    self.number = number
    self.text = hash["text"]

    
    if all_ans = hash["allowed_answers"]
      self.max_answers = all_ans["max"] unless all_ans["max"].blank? 
      self.min_answers = all_ans["min"] unless all_ans["min"].blank? 
    end
    
    self.answer_list = hash["answer_list"]
    aggregate_embedded(:answers)
    
    self.rule_list = hash.has_key?("rule_list") ? hash["rule_list"] : false
    aggregate_embedded(:rules)
  end
  
  def bulk_field_check
    @skope="question.yml.validations"
    
    errors.add(:text, I18n.t("#{@skope}.text_empty")) if text.blank?  
    errors.add(:answers, I18n.t("#{@skope}.answers_not_given")) if answers.blank?   
    errors.add(:rules, I18n.t("#{@skope}.rules_not_given")) if rule_list.nil?
  end
end