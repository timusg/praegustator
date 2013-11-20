class Praegustator
  module Mixin
    module FromFile

      def from_file(filename)
        if File.exists?(filename) && File.readable?(filename)
          self.instance_eval(IO.read(filename), filename, 1)
        else
          raise IOError, "Cannot open or read #{filename}!"
        end
      end

      def class_from_file(filename)
        if File.exists?(filename) && File.readable?(filename)
          self.class_eval(IO.read(filename), filename, 1)
        else
          raise IOError, "Cannot open or read #{filename}!"
        end
      end
    end
  end
end
