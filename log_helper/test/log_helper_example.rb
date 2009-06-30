class LogHelperExample
  include LogHelper
  
  def do_something()
    log_debug("entering method")
    n=0
    log_debug("done")
  end
  
end
