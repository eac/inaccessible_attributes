module EricChapweske
  module MassAssignmentLogging
  
    def self.included(base)
      base.class_eval do
        alias_method_chain :remove_attributes_protected_from_mass_assignment, :noticable_logging
      end
    end
  
    # Adds an additional, red-colored debug message when mass assignment fails with an attribute.
    def remove_attributes_protected_from_mass_assignment_with_noticable_logging(attributes)
      safe_attributes = remove_attributes_protected_from_mass_assignment_without_noticable_logging(attributes)
      unless attributes == safe_attributes
        logger.debug "\e[9;31;1mValues assigned to those attributes were ignored!\e[0m" 
      end
      safe_attributes
    end
    
  end
end