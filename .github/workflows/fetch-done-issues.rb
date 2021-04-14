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

    next unless column.name == 'Done'

    client.column_cards(column.id).each do |card|
      # original url comes like: https://api.github.com/repos/jeffrafter/project-summarizer-action/issues/2
      # we want: https://github.com/jeffrafter/project-summarizer-action/issues/2
      url = card.content_url
      url.slice!("api.")
      url.slice!("repos/")

      puts "    #{card.id}: #{url}"
    end
  end
end
