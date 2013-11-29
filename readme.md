Praegustator provide simple dsl to validate and test chef managed infrastructure, it is baced on ssh and utilize server spec in the backend.

## install

    gem install praegustator # install praegustator
    praeg --help
    praeg init spec_dir #setup praeg in current dir


## run
 
    praeg validate  #run all checks defined in recipes files
    praeg validate recipe # run recipe


## basic structure

Praegustator provides chef conventions based methods like  `role`, `recipe`, `ip`, `search` to group similar nodes for executing
check against them, whereas checks are rspec files with server-spec matchers defined in `spec_dir`

sample recipe for praegustator:

``` ruby
#sample_recipe.rb
environment :staging

role("web-server") do
 check "application/nginx"
 check "application/puma"
 check "application/s3cmd"
 properties :name => "foo"
end
```
The `role` method mark all nodes with that role .  Within the
block passed to `role` you can declare checks using the `check` method.
arbitrary hash can be passed to checks usin `properties` method, also
current node under test is added automatically to properties hash.

Where check are server spec files:

``` ruby
#{spec_dir}/application/nginx.rb

describe package('nginx') do
  it { should be_installed }
end

describe service('nginx') do
  it { should be_enabled   }
  it { should be_running   }
end

app_name = property[:name]
ip_address = property[:current_node].ipaddress

describe file("/etc/nginx/conf.d/#{app_name}.conf") do
  it { should contain "server_name #{ip_address}" }
end
```

## `praeg` command

Praegustator gem installs the `praeg` command,
Run `praeg --help` to see the help.

## praegustator configuration file

`.praegustator.yml` rovide ways to override various praegustator related settings, like
spec dir, recipes dir and ssh configuration


## ssh config file
  
   `praegustator` picks ssh configuration from `~/.ssh/config` file or
global ssh configuration defined in `.praegustator.yml`

## Useful links

* [http://github.com/rspec/rspec](http://github.com/rspec/rspec)
* [http://serverspec.org/](http://serverspec.org/)


# Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
