class Meta::SubAnswer
  include MongoMapper::EmbeddedDocument
  
  key :number, Integer
  key :text, String
  
  validate :bulk_field_check
  
  def assign_attrs(number, hash)
    return if hash.nil?
    self.number = number
    self.text = hash["text"]
  end
  
  def bulk_field_check
    errors.add(:sub_answer, I18n.t('sub_answer.yml.validations.text_not_given')) if text.blank?
    errors.add(:sub_answer, I18n.t('sub_answer.yml.validations.no_number_given')) if number.blank?
  end
end