# Mina::VersionManagers

[Mina](https://github.com/mina-deploy/mina) plugin with tasks for version managers, including [rbenv](https://github.com/rbenv/rbenv), [chruby](https://github.com/postmodern/chruby), [rvm](https://github.com/rvm/rvm), and [ry](https://github.com/jneen/ry).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mina-version_managers'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install mina-version_managers

## Usage

The following sections explain how to use tasks for each version manager.

### chruby

Require chruby tasks:
```ruby
# config/deploy.rb
require 'mina/version_managers/chruby'
```

This will load three tasks: `chruby:load`, `chruby:set`, and `chruby`.

#### chruby:load

Loads the chruby environment from the given path (default path is `/etc/profile.d/chruby.sh`). You can also override it:
```ruby
# config/deploy.rb
set :chruby_path, 'mypath/chruby.sh'
```
See [chruby docs](https://github.com/postmodern/chruby#configuration) for path details.

Example usage:
```ruby
# config/deploy.rb
task :deploy do
  deploy do
    invoke :'chruby:load'
  end
end
```

#### chruby:set

Sets current Ruby version, which must be provided as an argument.

Example usage:
```ruby
# config/deploy.rb
task :deploy do
  deploy do
    invoke :'chruby:set', '3.0.0' # sets current Ruby version to 3.0.0
  end
end
```

#### chruby

Convenience task which invokes `chruby:load` and `chruby:set`. Ruby version must be provided as an argument.

Example usage:
```ruby
# config/deploy.rb
task :deploy do
  deploy do
    invoke :chruby, '3.0.0' # loads chruby environment and sets current Ruby version to 3.0.0
  end
end
```

### rbenv

Require rbenv task:
```ruby
# config/deploy.rb
require 'mina/version_managers/rbenv'
```

This will load a single task: `rbenv:load`.

#### rbenv:load

Adds rbenv root path to the `PATH` environment variable, and executes `rbenv init`. Default rbenv root path is `$HOME/.rbenv`, but you can override it:
```ruby
# config/deploy.rb
set :rbenv_path, 'mypath/.rbenv'
```

Example usage:
```ruby
# config/deploy.rb
task :deploy do
  deploy do
    invoke :'rbenv:load'
  end
end
```

### RVM

Require RVM tasks:
```ruby
# config/deploy.rb
require 'mina/version_managers/rvm'
```

This will load three tasks: `rvm:load`, `rvm:use`, and `rvm:wrapper`.

#### rvm:load

Loads RVM from the given path. Default path is `$HOME/.rvm/scripts/rvm`, but it can be overriden:
```ruby
# config/deploy.rb
set :rvm_use_path, 'mypath'
```

Example usage:
```ruby
# config/deploy.rb
task :deploy do
  deploy do
    invoke :'rvm:load'
  end
end
```

#### rvm:use

Loads RVM (by invoking `rvm:load`) and sets current Ruby version, which should be provided as an argument.

Example usage:
```ruby
# config/deploy.rb
task :deploy do
  deploy do
    invoke :'rvm:use', '3.0.0' # loads RVM and changes current Ruby version to 3.0.0
  end
end
```

#### rvm:wrapper

Creates an RVM wrapper for the given environment and binary which will be wrapped.

Example usage:
```ruby
# config/deploy.rb
task :deploy do
  deploy do
    # creates a wrapper called `myapp` for the binary `unicorn_rails` in the environment `3.0.0`
    invoke :'rvm:wrapper', '3.0.0', 'myapp', 'unicorn_rails'
  end
end
```

### ry

Require ry tasks:
```ruby
# config/deploy.rb
require 'mina/version_managers/ry'
```

This will load three tasks: `ry:load`, `ry:use` and `ry`.

#### ry:load

Adds ry path to the `PATH` environment variable, and executes `ry setup`. Default ry path is `$HOME/.local`, but you can override it:
```ruby
# config/deploy.rb
set :ry_path, 'mypath/.local'
```

Example usage:
```ruby
# config/deploy.rb
task :deploy do
  deploy do
    invoke :'ry:load'
  end
end
```

#### ry:use

Sets current Ruby version, which can be provided as an argument. If you don't provide a version, the default Ruby version will be used.

Example usage:
```ruby
# config/deploy.rb
task :deploy do
  deploy do
    invoke :'ry:use', '3.0.0' # or don't set a param if you want to use the default version
  end
end
```

#### ry

Convenience task which invokes `ry:load` and `ry:use`. Ruby version can be provided as an argument or left blank to use the default version (same as `ry:use`).

Example usage:
```ruby
# config/deploy.rb
task :deploy do
  deploy do
    invoke :ry, '3.0.0'
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bundle exec rspec` to run the tests.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mina-deploy/mina-version_managers. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/mina-version_managers/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Mina::VersionManagers project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/mina-version_managers/blob/main/CODE_OF_CONDUCT.md).
