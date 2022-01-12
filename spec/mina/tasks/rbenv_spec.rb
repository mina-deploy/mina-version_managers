# frozen_string_literal: true

RSpec.describe 'rbenv', type: :rake do
  before do
    load_default_config
  end

  describe 'rbenv:load' do
    let(:task_name) { 'rbenv:load' }

    it 'has a description' do
      expect(task.comment).to eq('Load rbenv environment')
    end

    context 'when :rbenv_path is not set' do
      before do
        Mina::Configuration.instance.remove(:rbenv_path)
      end

      it 'exits with an error message' do
        expect do
          invoke_all
        end.to raise_error(SystemExit)
           .and output(output_file('rbenv_load_without_rbenv_path')).to_stdout
      end
    end

    context 'when :rbenv_path is set' do
      it 'loads rbenv environment' do
        expect do
          invoke_all
        end.to output(output_file('rbenv_load_with_rbenv_path')).to_stdout
      end
    end
  end
end
