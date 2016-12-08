#! /Users/jtsang/.rubies/ruby-2.3.0/bin/ruby

require './mason'
require 'yaml'

template = ARGV[0]
stub = ARGV[1]

template_hash = YAML.load_file template
# puts template_hash
stub_hash = YAML.load_file stub
# puts stub_hash

mason = Mason.new template: template_hash, stub: stub_hash

result = mason.merge!

File.open("./result.txt", "w+") do |file|
  file.write(result.to_yaml)
end

puts "Finished!"
