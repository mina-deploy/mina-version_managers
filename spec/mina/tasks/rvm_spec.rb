# frozen_string_literal: true

RSpec.describe 'rvm', type: :rake do
  before do
    load_default_config
  end

  describe 'rvm:load' do
    let(:task_name) { 'rvm:load' }

    it 'has a description' do
      expect(task.comment).to eq('Load RVM environment')
    end

    context 'when :rvm_use_path is not set' do
      before do
        Mina::Configuration.instance.remove(:rvm_use_path)
      end

      it 'exits with an error message' do
        expect do
          invoke_all
        end.to raise_error(SystemExit)
           .and output(output_file('rvm_load_without_rvm_use_path')).to_stdout
      end
    end

    context 'when :rvm_use_path is set' do
      it 'loads RVM environment' do
        expect do
          invoke_all
        end.to output(output_file('rvm_load_with_rvm_use_path')).to_stdout
      end
    end
  end

  describe 'rvm:use' do
    let(:task_name) { 'rvm:use' }

    it 'has a description' do
      expect(task.comment).to eq('Load RVM environment and set current Ruby version')
    end

    context 'without an argument' do
      it 'exits with an error message' do
        expect do
          invoke_all
        end.to raise_error(SystemExit)
           .and output(output_file('rvm_use_without_env')).to_stdout
      end
    end

    context 'with an argument' do
      it 'sets ruby version' do
        expect do
          invoke_all('3.0.0')
        end.to output(output_file('rvm_use_with_env')).to_stdout
      end
    end
  end

  describe 'rvm:wrapper' do
    let(:task_name) { 'rvm:wrapper' }

    it 'has a description' do
      expect(task.comment).to eq('Load RVM environment and create an RVM wrapper')
    end

    context 'without all arguments' do
      it 'exits with an error message' do
        expect do
          invoke_all('ruby-3.0.0')
        end.to raise_error(SystemExit)
           .and output(output_file('rvm_wrapper_without_arguments')).to_stdout
      end
    end

    context 'with all arguments' do
      it 'calls rvm wrapper' do
        expect do
          invoke_all('3.0.0', 'myapp', 'unicorn')
        end.to output(output_file('rvm_wrapper_with_arguments')).to_stdout
      end
    end
  end
end
