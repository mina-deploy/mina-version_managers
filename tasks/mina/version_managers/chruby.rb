# frozen_string_literal: true

set :chruby_path, '/etc/profile.d/chruby.sh'

namespace :chruby do
  desc 'Load chruby environment'
  task :load do
    ensure!(:chruby_path, message: "chruby path hasn't been set (check :chruby_path variable)")

    comment 'Loading chruby environment'
    command %(
      if [[ ! -s "#{fetch(:chruby_path)}" ]]; then
        echo "! chruby.sh init file not found"
        exit 1
      fi
    )
    command %(source #{fetch(:chruby_path)})
  end

  desc 'Set current Ruby version'
  task :set, :ruby_version do |_, args|
    unless args[:ruby_version]
      puts "Task 'chruby:set' needs a Ruby version as an argument."
      puts "Example: invoke :'chruby:set', 'ruby-2.4'"
      exit 1
    end

    comment %(Setting Ruby version to: \\"#{args[:ruby_version]}\\")
    command %(chruby "#{args[:ruby_version]}" || exit 1)
  end
end

desc 'Load chruby environment and set current Ruby version'
task :chruby, :ruby_version do |_, args|
  unless args[:ruby_version]
    puts "Task 'chruby' needs a Ruby version as an argument."
    puts "Example: invoke :chruby, 'ruby-2.4'"
    exit 1
  end

  invoke :'chruby:load'
  invoke :'chruby:set', args[:ruby_version]
end
