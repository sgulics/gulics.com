module Log
  class AnotherLogHelperExample
    include LogHelper
    def do_something
      log_debug("Hi")
    end
  end
end