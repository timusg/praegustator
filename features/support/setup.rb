require 'aruba/cucumber'

system "cd features_setup/setup/ && vagrant up"
system "cp features_setup/setup/.praegustator.yml tmp/aruba"
