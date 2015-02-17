Gem::Specification.new do |s|
  s.name        = 'autossh'
  s.version     = '0.0.7'
  s.date        = '2015-02-17'
  s.summary     = "AutoSSH"
  s.description = "An SSH connection helper"
  s.authors     = ["Paul Ridgway"]
  s.email       = 'myself@paulridgway.co.uk'
  s.homepage    = 'https://github.com/paul-ridgway/autossh'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- test/*`.split("\n")

  s.executables << 'assh'


  s.add_dependency("colorize", '~> 0')
  s.add_dependency("aws-sdk-v1", '~> 0')

end
