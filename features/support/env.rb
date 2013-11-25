require 'aruba/cucumber'
Aruba.configure do |config|
  config.before_cmd do |cmd|
    @aruba_timeout_seconds = 5
    system "cp ../../features_setup/setup/.praegustator.yml ."
  end
end
