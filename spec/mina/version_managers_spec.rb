# frozen_string_literal: true

RSpec.describe Mina::VersionManagers do
  it 'has a version number' do
    expect(Mina::VersionManagers::VERSION).not_to be nil
  end
end
