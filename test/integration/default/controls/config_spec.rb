# frozen_string_literal: true

control 'promtail configuration' do
  title 'should match desired lines'

  describe file('/opt/promtail/promtail.yaml') do
    it { should be_file }
    it { should be_owned_by 'root' }
    its('mode') { should cmp '0644' }
    its('content') do
      should include(
        'File managed by Salt at'
      )
    end
    its('content') { should include 'server:' }
    its('content') { should include '  http_listen_port: 9080' }
    its('content') { should include '- url: http://127.0.0.1:3100/loki/api/v1/push' }
  end
end
