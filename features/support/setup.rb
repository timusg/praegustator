require 'aruba/cucumber'

system "cd features_setup/setup/ && vagrant up"
system "cp features_setup/setup/.praegustator.yml tmp/aruba"


p "to stop test machine run `vagarnt halt` in features_setup/setup dir"
