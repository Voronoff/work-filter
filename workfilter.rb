mode = ARGV[0]
sites_list = File.open("./sites_list.txt", 'r')

if mode == "on" || mode.nil?
  hosts = File.open("/etc/hosts", 'a')
  sites_list.each {|site| hosts.puts("127.0.0.1	" + site)}
  hosts.close
elsif mode == "off"
  lines_to_keep = []
  hosts = File.open("/etc/hosts", 'r')
    hosts.each do |line| 
      delete_line = false
      sites_list.each do |site|
        delete_line = true if line[site]
      end
      lines_to_keep << line unless delete_line
      sites_list.rewind
    end
  hosts.close
  File.open("/etc/hosts", 'w') do |hosts|
    lines_to_keep.each {|line| hosts.puts(line)}
  end
else
  puts "Invalid mode. Please speciify on or off. If no mode is given, workfilter will be turned on."
end
sites_list.close
