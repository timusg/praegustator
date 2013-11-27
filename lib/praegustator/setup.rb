require 'praegustator'

module Praegustator
  class Setup
    def init(spec_dir)
      mkdir(spec_dir)
      create_spec spec_dir
      create_recepie  spec_dir
      create_settings  spec_dir
    end

    def mkdir dir
      if File.exists? dir
        $stderr.puts "!! #{dir} already exists"
      else
        FileUtils.mkdir dir
        puts " + #{dir}/"
        FileUtils.mkdir "#{dir}/checks"
        puts " + #{dir}/checks"
      end
    end

    def create_recepie dir
      content = <<-EOF
role("*")do
  check "basic_commands"
end
      EOF
      create_file "#{dir}/test_recipe.rb",content
    end

    def create_settings dir
      puts "please enter knife's location (default ~/.chef/knife.rb) : "
      knife_location = $stdin.gets.chomp
      knife_location = '~/.chef/knife.rb' if knife_location == ''

      content = <<-EOF
 spec:
   recipes_dir:  "#{dir}/"
   checks_dir:   "#{dir}/checks/"
 chef:
   knife_location: "#{knife_location}"
# ssh:
#   user: "root"
#   pasword: nil
#   keys: [ "~/.ssh/id_rsa" ]
      EOF
      create_file ".praegustator.yml",content
    end

    def create_spec dir
      content = <<-EOF
describe command('whoami') do
  it { should return_stdout 'vagrant' }
end

describe command('cat /etc/resolv.conf') do
  it { should return_stdout /8\.8\.8\.8/ }
end

describe command('ls /foo') do
  it { should return_stderr /No such file or directory/ }
end
      EOF
      create_file "#{dir}/checks/basic_commands.rb",content
    end

    private
    def create_file file, content
      if File.exists? file
        $stderr.puts "!! #{file} exists"
      else
        File.open("#{file}", 'w') do |f|
          f.puts content
        end
        puts " + #{file}"
      end
    end
  end
end

