class Meta::QuestionLS < Meta::Question
  key :max_subanswers, Integer, :default => -1
  key :min_subanswers, Integer, :default => 1
  
  many :subanswers, :class => Meta::Subanswer
  
  attr_accessor :subanswer_list
  
  def assign_attrs(number, hash)
    super
    
    if hash["allowed_subanswers"]
      self.max_subanswers = hash["allowed_subanswers"]["max"]
      self.min_subanswers = hash["allowed_subanswers"]["min"]
    end
    
    self.subanswer_list = hash["subanswer_list"]
    aggregate_embedded(:subanswers)
  end
  
  def bulk_field_check
    super
    
    errors.add(:subanswers, I18n.t("#{@skope}.subanswers_not_defined")) if subanswers.blank?   
  end
end