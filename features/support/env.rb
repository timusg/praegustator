require 'aruba/cucumber'
Aruba.configure do |config|
  config.before_cmd do |cmd|
    system "cp ../../features_setup/setup/.praegustator.yml ."
  end
end
