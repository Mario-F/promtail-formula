# frozen_string_literal: true

# Overide by OS
service_name = 'promtail'

control 'promtail service' do
  impact 0.5
  title 'should be running and enabled'

  describe service(service_name) do
    it { should be_enabled }
    it { should be_running }
  end
end
