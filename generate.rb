#!/usr/bin/env ruby

File.open('.generated-config', 'w') do |f|
	f << "Host test\n"
	f << "  Hostname proc-dp1.dlg.ie.aws.thefloow.net\n"
    f << "  Port 2219\n"
    f << "  User paul\n"
    f << "  IdentityFile ~/Dropbox/.ssh/floow/id_rsa"
end