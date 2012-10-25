hosts = File.open('/etc/hosts', 'a')
sites_list = File.open('./sites_list.txt', 'r')

sites_list.each {|site| hosts.puts("127.0.0.1	" + site)}

sites_list.close
hosts.close
