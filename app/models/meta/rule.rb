class Meta::Rule
  include MongoMapper::EmbeddedDocument
  
  key :number, Integer
  key :next_question, Integer
  key :condition, String
  key :expected_answers, Array
  
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