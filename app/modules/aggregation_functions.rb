module AggregationFunctions
    
  def aggregate_embedded(model_pluralized)
    singular_model=model_pluralized.to_s.singularize
    
    (self.send("#{singular_model}_list") || {}).each_key do |number|
      items = self.send("#{singular_model}_list")[number]
      if items.is_a? Hash
        klass = items["klass"]
        return unless klass.blank? or class_exists?(klass.camelize) 
      end
      m="Meta::#{(klass || singular_model).camelize}".constantize.new
      m.assign_attrs(number, items)
      self.send(model_pluralized.to_s).send('<<', m)
    end
  end
  
  def class_exists?(class_name)
    klass = Meta.const_get("#{class_name}")
    return klass.is_a?(Class)
  rescue NameError
    return false
  end
  
end