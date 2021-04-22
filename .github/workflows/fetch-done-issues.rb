require "octokit"
require 'json'

# Some documentation
# https://octokit.github.io/octokit.rb/Octokit/Client/Projects.html
# https://docs.github.com/en/rest/reference/projects

nwo = ENV['REPO_NWO']
project_name = ENV['PROJECT_NAME']

client = Octokit::Client.new(:access_token => ENV['GITHUB_TOKEN'])
projects = client.projects(nwo)
data = ""
projects.each do |project|
  puts "#{project.id}: #{project.name}"

  next unless project.name == project_name
  data +="### #{project_name}"

  client.project_columns(project.id).each do |column|
    puts "  #{column.id}: #{column.name}"

    next unless column.name == 'Done'

    client.column_cards(column.id).each do |card|
      # original url comes like: https://api.github.com/repos/jeffrafter/project-summarizer-action/issues/2
      # we want: https://github.com/jeffrafter/project-summarizer-action/issues/2
      url = card.content_url
      url.slice!("api.")
      url.slice!("repos/")

      puts "#{card.id}: #{url}"
      data << "#{url}"
    end
  end
end

# puts data.inspect
puts "::set-output name=SELECTED_COLOR::#{data}"