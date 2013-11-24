describe command('whoami') do
  it { should return_stdout 'vagrant' }
end

describe command('cat /etc/resolv.conf') do
  it { should return_stdout /8\.8\.8\.8/ }
end

describe command('ls /foo') do
  it { should return_stderr /No such file or directory/ }
end
