Praegustator provide simple dsl to validate and test chef managed infrastructure, it use remote ssh and utilize server spec in the backend to define checks.

## install

    gem install praegustator # install praegustator
    praeg --help
    praeg init spec_dir #setup praeg in current dir


## run
 
    praeg validate  #run all recipes
    praeg validate recipe # run recipe


## basic structure

Praegustator provides chef conventions based methods like  `role`, `recipe`, `ip`, `search` to group similar nodes for executing
check against them, whereas checks are rspec files with server-spec matchers defined in `spec_dir`

sample recipe for praegustator:

``` ruby  sample_recipe.rb
environment :staging

role("web-server") do
 check "application/nginx"
 check "application/puma"
 check "application/s3cmd"
end
```
The `role` method mark all nodes with that role .  Within the
block passed to `role` you can declare checks using the `check` method.

Where check are server spec files:

``` ruby  #{spec_dir}/application/nginx.rb
describe package('nginx') do
  it { should be_installed }
end

describe service('nginx') do
  it { should be_enabled   }
  it { should be_running   }
end
```

## `praeg` command

Praegustator gem installs the `praeg` command,
Run `praeg --help` to see the help.

## praegustator configuration file `.praegustator.yml`

Provide way to override various praegustator related settings , like
spec dir , recipe dir and ssh configuration


## ssh config file
  
   `praegustator` picks ssh configuration for a node from `~/.ssh/config` file or
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
