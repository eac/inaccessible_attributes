ActiveRecord::Base.send(:extend, EricChapweske::InaccessibleAttributes)
ActiveRecord::Base.send(:include, EricChapweske::MassAssignmentLogging)
ActiveRecord::Migration.send(:extend, EricChapweske::MigrationWarning)
