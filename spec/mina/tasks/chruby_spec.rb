# frozen_string_literal: true

RSpec.describe 'chruby', type: :rake do
  before do
    load_default_config
  end

  describe 'chruby:load' do
    let(:task_name) { 'chruby:load' }

    it 'has a description' do
      expect(task.comment).to eq('Load chruby environment')
    end

    context 'when :chruby_path is not set' do
      before do
        Mina::Configuration.instance.remove(:chruby_path)
      end

      it 'exits with an error message' do
        expect do
          invoke_all
        end.to raise_error(SystemExit)
           .and output(output_file('chruby_load_without_chruby_path')).to_stdout
      end
    end

    context 'when :chruby_path is set' do
      before do
        Mina::Configuration.instance.set(:chruby_path, 'mypath/chruby.sh')
      end

      it 'loads chruby environment' do
        expect do
          invoke_all
        end.to output(output_file('chruby_load_with_chruby_path')).to_stdout
      end
    end
  end

  describe 'chruby:set' do
    let(:task_name) { 'chruby:set' }

    it 'has a description' do
      expect(task.comment).to eq('Set current Ruby version')
    end

    context 'without a Ruby version argument' do
      it 'exits with an error message' do
        expect do
          invoke_all
        end.to raise_error(SystemExit)
           .and output(output_file('chruby_set_without_ruby_version')).to_stdout
      end
    end

    context 'with a Ruby version argument' do
      it 'sets Ruby version' do
        expect do
          invoke_all('123')
        end.to output(output_file('chruby_set_with_ruby_version')).to_stdout
      end
    end
  end

  describe 'chruby' do
    let(:task_name) { 'chruby' }

    it 'has a description' do
      expect(task.comment).to eq('Load chruby environment and set current Ruby version')
    end

    context 'without a Ruby version argument' do
      it 'exits with an error message' do
        expect do
          invoke_all
        end.to raise_error(SystemExit)
           .and output(output_file('chruby_without_ruby_version')).to_stdout
      end
    end

    context 'with an argument' do
      it 'sets Ruby version' do
        expect do
          invoke_all('123')
        end.to output(output_file('chruby_with_ruby_version')).to_stdout
      end
    end
  end
end
