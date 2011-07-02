module AggregationFunctions
  
  def aggregate_embedded(model)
    singular_model=model.to_s.singularize
    
    (self.send("#{singular_model}_list") || {}).each_key do |number|
      m=singular_model.camelize.constantize.new
      m.assign_attrs(number, self.send("#{singular_model}_list").send('[]', number))
      self.send(model.to_s).send('<<', m)
    end
  end
  
end