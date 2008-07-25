require 'test/unit'
require File.expand_path(File.join(File.dirname(__FILE__), '../../../../config/environment.rb'))
require 'rubygems'


class InaccessibleAttributesTest < Test::Unit::TestCase
  
  class InaccessibleRecord < ActiveRecord::Base
    attr_accessor :name

    def mass_assign(attributes)
      remove_attributes_protected_from_mass_assignment(attributes)
    end
  end

  class AccessibleRecord < ActiveRecord::Base
    disable_mass_assignment = false
  end

  # Replace this with your real tests.
  def test_attr_protected_should_be_unusable_by_subclasses
    InaccessibleRecord.send(:attr_protected, :name)
  end
  
  def test_should_not_allow_any_attributes_to_be_mass_assigned_by_default
    accessible_attributes = mass_assign_attributes_to_inaccessible_record(:name => 'Batman')
    
    assert !accessible_attributes.include?('Batman')
  end
  
  def test_attributes_should_be_mass_assignable_after_being_specified_with_attr_accessible
    InaccessibleRecord.attr_accessible :name
    accessible_attributes = mass_assign_attributes_to_inaccessible_record(:name => 'Batman')
    
    assert accessible_attributes.include?('Batman')
  ensure
    InaccessibleRecord.accessible_attributes.delete(:name)
  end
  
  def test_should_log_additional_message_when_removed_from_mass_assignment
    setup_testable_logger
    mass_assign_attributes_to_inaccessible_record(:name => 'Batman')
    
    assert_match /Batman/, log.string
  ensure
    revert_to_original_logger
  end
  
  def test_should_not_log_additional_message_when_not_removed_from_mass_assignment
    setup_testable_logger
    InaccessibleRecord.attr_accessible :name
    mass_assign_attributes_to_inaccessible_record(:name => 'Batman')
  
    assert_no_match /Batman/, log.string
  ensure
    revert_to_original_logger
    InaccessibleRecord.accessible_attributes.delete(:name)
  end

  protected
    def mass_assign_attributes_to_inaccessible_record(attributes)
      inaccessible_record = InaccessibleRecord.new
      inaccessible_record.mass_assign(attributes)
    end
  
    def setup_testable_logger
      @original_logger = ActiveRecord::Base.logger
      log = StringIO.new
      ActiveRecord::Base.logger = Logger.new(log)
    end
    
    def revert_to_original_logger
      ActiveRecord::Base.logger = @original_logger
    end
    
end
