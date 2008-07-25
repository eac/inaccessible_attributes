module EricChapweske
  module MigrationWarning #ActiveRecord::Migration
    
    def self.extended(base)
      class << base
        alias_method_chain :migrate, :mass_assignment_warning
      end
    end
      
    # Adds a warning message during migrations.
    # Example:
    # == 57 CreateUsers: New attributes will be ignored by mass assignment unless `attr_accessible :attribute` is specified in their model. 
    # == 57 CreateUsers: migrating ========================================================
    # == 57 CreateUsers: migrated (0.0001s) ===============================================
    
    def migrate_with_mass_assignment_warning(direction)
      if direction == :up
        announce "New attributes will be ignored by mass assignment unless `attr_accessible :attribute` is specified in their model."
      end
      migrate_without_mass_assignment_warning(direction)
    end
      
  end
end