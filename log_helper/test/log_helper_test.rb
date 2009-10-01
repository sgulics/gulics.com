require 'test/unit'
require 'rubygems'
require 'mocha'
require 'logger'


require File.dirname(__FILE__) + '/../lib/log_helper'
require File.dirname(__FILE__) + '/log_helper_example'
require File.dirname(__FILE__) + '/log/another_log_helper_example'
class LogHelperTest < Test::Unit::TestCase
  # Replace this with your real tests.
  def test_should_pass_in_callers_classname_method_name_and_line_number
    Logger.any_instance.expects(:debug).with("LogHelperExample:do_something:(5):entering method").once
    Logger.any_instance.expects(:debug).with("LogHelperExample:do_something:(7):done").once
    #Object.any_instance.expects(:puts).never
    example = LogHelperExample.new
    example.do_something
  end
  
  def test_should_handle_modules
    example = Log::AnotherLogHelperExample.new
    example.do_something
    
  end
  
  def test_should_log_to_stdout_if_rails_env_is_set
    ["test", "development"].each do |env|
      LogHelperExample.const_set(:RAILS_ENV, env)
      LogHelperExample.any_instance.expects(:puts).with("LogHelperExample:do_something:(5):entering method").once
      LogHelperExample.any_instance.expects(:puts).with("LogHelperExample:do_something:(7):done").once
      example = LogHelperExample.new
      example.do_something
    end
    
  end
  
  def test_should_create_methods_for_each_log_level
    example = LogHelperExample.new
    [:log_debug, :log_info, :log_warn, :log_error, :log_fatal].each do |level|
      assert example.respond_to?(level)
    end
    
    
    
  end
end
