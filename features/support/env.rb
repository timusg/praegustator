require 'aruba/cucumber'
Aruba.configure do |config|
  config.before_cmd do |cmd|
    @aruba_timeout_seconds = 10
    system "cp ../../features_setup/setup/.praegustator.yml ."
  end
end
