# Include hook code here
require 'log_helper'
ActiveRecord::Base.send(:include, LogHelper)
ActionController::Base.send(:include, LogHelper)