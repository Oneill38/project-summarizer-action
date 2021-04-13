require "octokit"

nwo = ENV['PROJECT_NWO']
client = Octokit::Client.new(:access_token => ENV['GITHUB_TOKEN'])
projects = client.projects(nwo)
projects.each do |project|
  # Print the project id: name and the number of open issues
  puts "#{project.id}: #{project.name} (#{project.open_issues_count})"
end




# puts "This is super cool"
# puts "#{user.to_yaml}"
# puts "#{ENV['PROJECT_NWO']}"
# puts "#{ENV['PROJECT_ID']}"

