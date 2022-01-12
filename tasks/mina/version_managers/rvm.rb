# frozen_string_literal: true

set :rvm_use_path, '$HOME/.rvm/scripts/rvm'

namespace :rvm do
  desc 'Load RVM environment'
  task :load do
    ensure!(:rvm_use_path, message: "RVM path hasn't been set (check :rvm_use_path variable)")

    comment 'Loading RVM environment'
    command %(
      if [[ ! -s "#{fetch(:rvm_use_path)}" ]]; then
        echo "! Ruby Version Manager not found"
        echo "! If RVM is installed, check your :rvm_use_path variable."
        exit 1
      fi
    )
    command %(source #{fetch(:rvm_use_path)})
  end

  desc 'Load RVM environment and set current Ruby version'
  task :use, :env do |_, args|
    unless args[:env]
      puts "Task 'rvm:use' needs an RVM environment name as an argument."
      puts "Example: invoke :'rvm:use', 'ruby-1.9.2@default'"
      exit 1
    end

    invoke :'rvm:load'

    comment %(Using RVM environment \\\"#{args[:env]}\\\")
    command %(rvm use "#{args[:env]}" --create)
  end

  desc 'Load RVM environment and create an RVM wrapper'
  task :wrapper, :env, :name, :bin do |_, args|
    unless args[:env] && args[:name] && args[:bin]
      puts "Task 'rvm:wrapper' needs an RVM environment name, a wrapper name and the binary name as arguments"
      puts "Example: invoke :'rvm:wrapper', 'ruby-1.9.2@myapp', 'myapp', 'unicorn_rails'"
      exit 1
    end

    invoke :'rvm:load'

    comment "Creating RVM wrapper \"#{args[:name]}_#{args[:bin]}\" using \\\"#{args[:env]}\\\""
    command "rvm wrapper #{args[:env]} #{args[:name]} #{args[:bin]} || exit 1"
  end
end
