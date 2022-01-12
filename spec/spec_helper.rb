# frozen_string_literal: true

require 'simplecov'

SimpleCov.start do
  add_filter '/spec/'

  enable_coverage :branch
  primary_coverage :branch
end

require 'mina/version_managers'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].sort.each { |f| require f }

Rake.application = Mina::Application.new

require 'mina/default'
Dir['./tasks/mina/version_managers/**/*.rb'].sort.each { |f| require f }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!
  config.raise_errors_for_deprecations!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include RakeExampleGroup, type: :rake

  initial_task_names = Rake.application.tasks.to_set(&:name)
  initial_variables = Mina::Configuration.instance.variables

  config.before do
    Mina::Configuration.instance.instance_variable_set(:@variables, initial_variables.clone)
  end

  config.after do
    Rake.application.instance_variable_get(:@tasks).keep_if { |task_name, _| initial_task_names.include?(task_name) }
    Rake.application.tasks.each(&:reenable)
  end

  config.around(:each, :suppressed_output) do |example|
    original_stdout, $stdout = $stdout, File.open(File::NULL, 'w')
    original_stderr, $stderr = $stderr, File.open(File::NULL, 'w')

    example.run

    $stdout, $stderr = original_stdout, original_stderr
  end

  config.around do |example|
    example.run
  rescue SystemExit
    raise "Unhandled system exit (you're probably missing a raise_error(SystemExit) matcher somewhere)"
  end
end
