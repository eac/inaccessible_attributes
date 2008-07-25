module EricChapweske
  module InaccessibleAttributes
  
    def self.extended(base)
      base.disable_mass_assignment
    end
    
    # If true, requires each attribute to be specified during mass assignment and effectively disables attr_protected.
    def disable_mass_assignment(disable = true)
      disable ? enable_attr_inaccessible : disable_attr_inaccessible
    end
    
    private
      # Create an empty collection of accessible_attributes
      def enable_attr_inaccessible
        attr_accessible '_none_by_default'
        accessible_attributes.delete('_none_by_default')
      end
      
      def disable_attr_inaccessible
        if accessible_attributes.blank?
          write_inheritable_attribute('attr_accessible', nil)
        else
          raise "attr_accessible already defined for #{ accessible_attributes.join(', ') }. Can't disable" 
        end
      end
      
  end
end