#!/usr/bin/env ruby

PREFIX=ENV['INSTN_IPV6_PREFIX'] || "fd6f:6672:dfac::"

def hwaddr_from_serial(prefix, serial)
  host_id = serial[1..2] + serial[4..10]
  "02:00" + host_id.gsub(/\w{2}/, ':\0')
end

def ip_from_serial(prefix, serial)
  hwaddr = hwaddr_from_serial(prefix,serial)
  `ipv6calc --in prefix+mac #{prefix} #{hwaddr} --out ipv6addr --action prefixmac2ipv6`
end

puts "MAC: #{hwaddr_from_serial(PREFIX, ARGV[0])}"
puts "IPv6: #{ip_from_serial(PREFIX, ARGV[0])}"
