# frozen_string_literal: true

set :rbenv_path, '$HOME/.rbenv'

namespace :rbenv do
  desc 'Load rbenv environment'
  task :load do
    ensure!(:rbenv_path, message: "rbenv path hasn't been set (check :rbenv_path variable)")

    comment %(Loading rbenv environment)
    command %(export RBENV_ROOT="#{fetch(:rbenv_path)}")
    command %(export PATH="#{fetch(:rbenv_path)}/bin:$PATH")
    command %(
      if ! which rbenv >/dev/null; then
        echo "! rbenv not found"
        echo "! If rbenv is installed, check your :rbenv_path variable."
        exit 1
      fi
    )
    command %{eval "$(rbenv init -)"}
  end
end
