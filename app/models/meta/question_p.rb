class Meta::QuestionP < Meta::Question
  field :max_weighing, type: Integer, default: -> { -1 }
  field :min_weighing, type: Integer, default: -> { 1 }
  
  def assign_attrs(number, hash)
    super
    
    if hash["weighing"]
      self.max_weighing &&= hash["weighing"]["max"]
      self.min_weighing &&= hash["weighing"]["min"]
    end
  end
end