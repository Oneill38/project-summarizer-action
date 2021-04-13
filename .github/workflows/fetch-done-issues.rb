require "octokit"
require 'json'

# Some documentation
# https://octokit.github.io/octokit.rb/Octokit/Client/Projects.html
# https://docs.github.com/en/rest/reference/projects

nwo = ENV['PROJECT_NWO']

client = Octokit::Client.new(:access_token => ENV['GITHUB_TOKEN'])
projects = client.projects(nwo)
projects.each do |project|
  # TODO: do we want to check that the project name is a match
  puts "#{project.id}: #{project.name}"

  client.project_columns(project.id).each do |column|
    puts "  #{column.id}: #{column.name}"

    if column.name == 'Done'
      client.column_cards(column.id).each do |card|
        puts "    #{card.id}: #{card.inspect}"
        puts card.map(&:to_h).to_json(:indent => 4)
      end
    end
  end
end