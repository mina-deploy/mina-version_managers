# frozen_string_literal: true

require_relative 'lib/mina/version_managers/version'

Gem::Specification.new do |spec|
  spec.name          = 'mina-version_managers'
  spec.version       = Mina::VersionManagers::VERSION
  spec.authors       = ['Lovro Bikić']
  spec.email         = ['lovro.bikic@gmail.com']

  spec.summary       = 'Mina plugin for version managers'
  spec.homepage      = 'https://github.com/mina-deploy/mina-version_managers'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.5.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/mina-deploy/mina-version_managers'
  spec.metadata['changelog_uri'] = 'https://github.com/mina-deploy/mina-version_managers/blob/master/CHANGELOG.md'
  spec.metadata['rubygems_mfa_required'] = 'true'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.executables   = spec.files.grep(%r{\Abin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib', 'tasks']

  spec.add_dependency 'mina', '>= 1.0.0'

  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-rspec'
  spec.add_development_dependency 'simplecov'
end
