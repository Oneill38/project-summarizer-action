require "octokit"
require 'json'

# Some documentation
# https://octokit.github.io/octokit.rb/Octokit/Client/Projects.html
# https://docs.github.com/en/rest/reference/projects

nwos = ENV['REPO_NWO'].split(",")
project_names = ENV['PROJECT_NAME'].split(",")

client = Octokit::Client.new(:access_token => ENV['GITHUB_TOKEN'])

nwos.each_with_index do |nwo,idx|
  project_name = project_names[idx]
  projects = client.projects(nwo)
  projects.each do |project|
    # puts "#{project.id}: #{project.name}"

    next unless project.name == project_name
    puts "### #{project_name}\n"

    client.project_columns(project.id).each do |column|
      # puts "  #{column.id}: #{column.name}"

      next unless column.name == 'Done'

      client.column_cards(column.id).each do |card|
        next if card.updated_at < 1.week.ago
        next if card.archived
        # original url comes like: https://api.github.com/repos/jeffrafter/project-summarizer-action/issues/2
        # we want: https://github.com/jeffrafter/project-summarizer-action/issues/2
        url = card.content_url
        url.slice!("api.")
        url.slice!("repos/")

        # puts "#{card.id}: #{url}"
        puts "- #{url}\n"
      end
    end
  end
end

# puts data.inspect