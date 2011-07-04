class Meta::QuestionP < Meta::Question
  key :max_weighing, Integer, :default => -1
  key :min_weighing, Integer, :default => 1
  
  def assign_attrs(number, hash)
    super
    
    if hash["weighing"]
      self.max_weighing &&= hash["weighing"]["max"]
      self.min_weighing &&= hash["weighing"]["min"]
    end
  end
end