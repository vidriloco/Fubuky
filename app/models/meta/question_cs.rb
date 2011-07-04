class Meta::QuestionCS < Meta::QuestionP
  def assign_attrs(number, hash)
    super
    
    self.max_weighing = 100 if self.max_weighing == -1
  end
end