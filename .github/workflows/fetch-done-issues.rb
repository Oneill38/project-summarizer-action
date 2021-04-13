require "octokit"

client = Octokit::Client.new(:access_token => ENV['GITHUB_TOKEN'])
projects = client.projects("#{ENV['PROJECT_NWO']}/projects")
puts projects.to_yaml




# puts "This is super cool"
# puts "#{user.to_yaml}"
# puts "#{ENV['PROJECT_NWO']}"
# puts "#{ENV['PROJECT_ID']}"

