require "octokit"

client = Octokit::Client.new(:access_token => ENV['GITHUB_TOKEN'])
user = client.user

puts "This is super cool"
puts "#{user.to_yaml}"
puts "#{ENV['PROJECT_NWO']}"
puts "#{ENV['PROJECT_ID']}"

