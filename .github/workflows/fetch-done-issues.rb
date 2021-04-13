require "octokit"

puts "#{ENV['GITHUB_TOKEN'].reverse}"
nwo = ENV['PROJECT_NWO']
client = Octokit::Client.new(:access_token => ENV['GITHUB_TOKEN'])
projects = client.projects(nwo)
puts projects.to_json




# puts "This is super cool"
# puts "#{user.to_yaml}"
# puts "#{ENV['PROJECT_NWO']}"
# puts "#{ENV['PROJECT_ID']}"

