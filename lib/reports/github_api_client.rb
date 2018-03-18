require 'faraday'
require 'json'

module Reports

  class GitHubAPIClient
    User = Struct.new(:name, :location, :public_repos)
    
    def self.get_user(username)
      response = Faraday.get "https://api.github.com/users/#{username}"
      data = JSON.parse(response.body)
      User.new(data['name'], data['location'], data['public_repos'])
    end
  end

end
