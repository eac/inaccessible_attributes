Inaccessible Attributes
=======================

This plugin disables mass assignment by default, and prevents the use of attr_protected. Attributes safe for mass assignment must be specified using attr_accessible. Logging is also improved to help prevent attr_accessible-related errors:
* A message is displayed during migrations as a reminder to use attr_accessible for newly added attributes.
* The 'removed from mass assignment' logger warning is more noticeable in development.

Disabling Inaccessible Attributes
=================================
Some third party/legacy code may not play nice with this plugin.
The behavior can be disabled with the disable_mass_assignment method:
=> ThirdPartyModel.send(:disable_mass_assignment, false)

In your own classes, the plugin must be disabled before the offending code is mixed in.
class MyModel < ActiveRecord::Base
  disable_mass_assignment false
  include BehaviorWithAttrProtected 

  ...
end

Keep a look out for potential mass assignment problems during testing:
tail -f log/test.log | grep WARNING

Copyright (c) 2008 Eric Chapweske, released under the MIT license
