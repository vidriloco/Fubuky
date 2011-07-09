class Meta::QuestionLS < Meta::Question
  field :max_subanswers, type: Integer, default: -> { -1 }
  field :min_subanswers, type: Integer, default: -> { 1 }
  embeds_many :sub_answers, :class_name => "Meta::SubAnswer"
  
  attr_accessor :sub_answer_list
  
  validates_associated :sub_answers, :message => I18n.t("question.yml.validations.sub_answers_invalid")
  
  def assign_attrs(number, hash)
    super
    
    if hash["allowed_subanswers"]
      self.max_subanswers = hash["allowed_subanswers"]["max"]
      self.min_subanswers = hash["allowed_subanswers"]["min"]
    end
    
    self.sub_answer_list = hash["subanswer_list"]
    aggregate_embedded(:sub_answers)
  end
  
  def bulk_field_check
    super
    
    errors.add(:subanswers, I18n.t("#{@skope}.sub_answers_not_defined")) if sub_answers.blank?   
  end
end