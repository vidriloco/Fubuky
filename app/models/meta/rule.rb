class Meta::Rule
  include Mongoid::Document  
  
  field :number, type: Integer
  field :next_question, type: Integer
  field :condition, type: String
  field :expected_answers, type: Array
  
  embedded_in :question, :class_name => "Meta::Question"
  
  validate :bulk_field_check
  
  def assign_attrs(number, hash)
    return if hash.nil?
    self.number = number
    
    hash.each_key { |key| self.send("#{key}=", hash[key]) }
  end
  
  def bulk_field_check
    errors.add(:rule, I18n.t('rule.yml.validations.condition_not_given')) if condition.blank?
    errors.add(:rule, I18n.t('rule.yml.validations.next_question_not_given')) if next_question.blank?
    errors.add(:rule, I18n.t('rule.yml.validations.expected_answers_not_given')) if expected_answers.blank?
    errors.add(:rule, I18n.t('rule.yml.validations.no_number_given')) if number.blank?
  end
end