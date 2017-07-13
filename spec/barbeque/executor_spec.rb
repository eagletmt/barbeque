require 'rails_helper'
require 'barbeque/executor'

describe Barbeque::Executor do
  describe '.create' do
    before do
      config = Barbeque.build_config(barbeque_yml)
      allow(Barbeque).to receive(:config).and_return(config)
    end

    context 'without executor_options' do
      let(:barbeque_yml) { 'barbeque' }

      it 'initializes a configured executor' do
        expect(Barbeque::Executor::Docker).to receive(:new).with({})
        Barbeque::Executor.create
      end
    end

    context 'with executor_options' do
      let(:barbeque_yml) { 'barbeque.hako' }

      it 'initializes a configured executor with configured options' do
        expect(Barbeque::Executor::Hako).to receive(:new).with(
          hako_dir: '/home/k0kubun/hako_repo',
          hako_env: { 'ACCESS_TOKEN' => 'token' },
          yaml_dir: '/yamls'
        )
        Barbeque::Executor.create
      end
    end
  end
end
