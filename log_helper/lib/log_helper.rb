# LogHelper
module LogHelper
  module ClassMethods
    
  end
  
  module InstanceMethods
    def get_logger
      return logger if defined?(logger) 
      return RAILS_DEFAULT_LOGGER if defined?(RAILS_DEFAULT_LOGGER)
      require 'logger'
      @logger ||= Logger.new(STDOUT)
      return @logger
    end
    
    def get_caller(ca)
      # "#{$1.respond_to?(:camelize) ? $1.camelize : $1}:#{$3}:(#{$2})" if /(\w*)\.rb:(\d*):in `([^']*)'/.match( ca[0]) 
      "#{self.class.name}:#{$2}:(#{$1})" if /:(\d*):in `([^']*)'/.match( ca[0]) 
    end
    
    
  end
  
  def self.define_log_helper(base, level)
    base.class_eval <<-end_eval
      def log_#{level}(string, &block)
        log_string = "\#{get_caller(caller)}:\#{string}"
        puts log_string if defined?(RAILS_ENV) && (RAILS_ENV == 'test' || RAILS_ENV == 'development')
        get_logger.#{level}(log_string, &block)
      end
    end_eval
  end
  
  def self.included(base)
    base.send :include, InstanceMethods
    [:debug, :info, :warn, :error, :fatal].each {|level| define_log_helper(base, level) }
  end
end
