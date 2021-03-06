require 'barbeque/runner/hako'
require 'barbeque/docker_image'

describe Barbeque::Runner::Hako do
  let(:hako_directory) { '.' }
  let(:github_access_token) { 'access_token' }

  describe '#run' do
    let(:app_name) { 'dummy' }
    let(:tag) { 'latest' }
    let(:docker_image) { Barbeque::DockerImage.new("#{app_name}:#{tag}") }
    let(:job_command) { ['bundle', 'exec', 'barbeque:execute'] }
    let(:hako_env) { { 'AWS_REGION' => 'ap-northeast-1' } }
    let(:envs) { { 'FOO' => 'BAR' } }

    it 'runs hako oneshot command within HAKO_DIR' do
      expect(Open3).to receive(:capture3).with(
        hako_env,
        'bundle', 'exec', 'hako', 'oneshot', '--tag', tag,
        '--env=FOO=BAR', "/yamls/#{app_name}.yml", '--', *job_command,
        chdir: hako_directory,
      )
      Barbeque::Runner::Hako.new(
        docker_image: docker_image,
        hako_dir: hako_directory,
        hako_env: hako_env,
        yaml_dir: '/yamls',
      ).run(job_command, envs)
    end
  end
end
