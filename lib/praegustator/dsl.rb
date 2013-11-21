require 'praegustator'
module Praegustator
  class Dsl
    def role(name, &block)
    end

    def recipe(name, &block)
    end

    def search(name, &block)
    end

    def parse_file(filename)
      if File.exists?(filename) && File.readable?(filename)
        self.instance_eval(IO.read(filename), filename, 1)
      else
        raise IOError, "Cannot open or read #{filename}!"
      end
    end
  end
end

