class Meta::Answer
  include Mongoid::Document
  
  field :number, type: Integer
  field :text, type: String
  field :style, type: String, default: -> { "Closed" } 
  
  embedded_in :question, :class_name => "Meta::Question"
  
  validate :bulk_field_check
  
  def assign_attrs(number, hash)
    return if hash.nil?
    self.number = number
    self.text = hash["text"]
    self.style = hash["style"] if hash["style"]
  end
  
  def bulk_field_check
    errors.add(:answer, I18n.t('answer.yml.validations.empty')) if(text.blank? || number.blank?)
  end
  
end