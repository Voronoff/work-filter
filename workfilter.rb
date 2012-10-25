mode = ARGV[0]
sites_list = File.open("./sites_list.txt", 'r')

if mode == "on" || mode.nil?
  File.open("/etc/hosts", 'a') do |hosts|
  sites_list.each {|site| hosts.puts("127.0.0.1	" + site)}
  end
elsif mode == "off"
  lines_to_keep = []
  File.open("/etc/hosts", 'r') do |hosts|
    hosts.each do |line| 
      delete_line = false
      sites_list.each {|site| delete_line = true if line["127.0.0.1	" + site]}
      lines_to_keep << line unless delete_line
      sites_list.rewind
    end
  end

  File.open("/etc/hosts", 'w') do |hosts|
    lines_to_keep.each {|line| hosts.puts(line)}
  end
else
  puts "Invalid mode. Please speciify on or off. If no mode is given, workfilter will be turned on."
end

sites_list.close
