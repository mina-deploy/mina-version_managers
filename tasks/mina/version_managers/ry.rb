# frozen_string_literal: true

set :ry_path, '$HOME/.local'

namespace :ry do
  desc 'Load ry environment'
  task :load do
    ensure!(:ry_path, message: "ry path hasn't been set (check :ry_path variable)")

    comment %(Loading ry environment)
    command %(
      if [[ ! -e "#{fetch(:ry_path)}/bin" ]]; then
        echo "! ry not found"
        echo "! If ry is installed, check your :ry_path variable."
        exit 1
      fi
    )
    command %(export PATH="#{fetch(:ry_path)}/bin:$PATH")
    command %{eval "$(ry setup)"}
  end

  desc 'Set current ruby version'
  task :use, :ruby_version do |_, args|
    puts "Task 'ry:use' without an argument will use default Ruby version." unless args[:ruby_version]

    comment %(Setting Ruby version to: \\"#{args[:ruby_version] || '**not specified**'}\\")
    command %(RY_RUBY="#{args[:ruby_version]}")
    command %(
      if [ -n "$RY_RUBY" ]; then
        #{echo_cmd 'ry use $RY_RUBY'} || exit 1
      fi
    )
  end
end

desc 'Load ry environment and set current Ruby version'
task :ry, :env do |_, args|
  invoke :'ry:load'
  invoke :'ry:use', args[:env]
end
