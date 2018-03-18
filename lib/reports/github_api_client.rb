require 'faraday'
require 'json'

module Reports

  class GitHubAPIClient
    User = Struct.new(:name, :location, :public_repos)

    def self.get_user(username)
      url = "https://api.github.com/users/#{username}"

      start_time = Time.now
      response = Faraday.get url
      duration = Time.now - start_time

      puts "-> %s %s %d (%.3f s)" % [url, 'GET', response.status, duration]

      data = JSON.parse(response.body)
      User.new(data['name'], data['location'], data['public_repos'])
    end
  end

end
