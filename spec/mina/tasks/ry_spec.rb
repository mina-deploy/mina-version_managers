# frozen_string_literal: true

RSpec.describe 'ry', type: :rake do
  before do
    load_default_config
  end

  describe 'ry:load' do
    let(:task_name) { 'ry:load' }

    it 'has a description' do
      expect(task.comment).to eq('Load ry environment')
    end

    context 'when :ry_path is not set' do
      before do
        Mina::Configuration.instance.remove(:ry_path)
      end

      it 'exits with an error message' do
        expect do
          invoke_all
        end.to raise_error(SystemExit)
           .and output(output_file('ry_load_without_ry_path')).to_stdout
      end
    end

    context 'when :ry_path is set' do
      it 'loads ry environment' do
        expect do
          invoke_all
        end.to output(output_file('ry_load_with_ry_path')).to_stdout
      end
    end
  end

  describe 'ry:use' do
    let(:task_name) { 'ry:use' }

    context 'without a Ruby version argument' do
      it 'sets default Ruby version' do
        expect do
          invoke_all
        end.to output(output_file('ry_use_without_ruby_version')).to_stdout
      end
    end

    context 'with a Ruby version argument' do
      it 'sets the given Ruby version' do
        expect do
          invoke_all('3.0.0')
        end.to output(output_file('ry_use_with_ruby_version')).to_stdout
      end
    end
  end

  describe 'ry' do
    let(:task_name) { 'ry' }

    it 'has a description' do
      expect(task.comment).to eq('Load ry environment and set current Ruby version')
    end

    it 'loads ry environment and sets current Ruby version' do
      expect do
        invoke_all('3.0.0')
      end.to output(output_file('ry_with_ruby_version')).to_stdout
    end
  end
end
