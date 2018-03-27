require 'faraday'
require 'json'
require 'logger'
require 'byebug'

module Reports
  class NonexistentUser < StandardError; end

  User = Struct.new(:name, :location, :public_repos)

  class GitHubAPIClient
    attr_reader :logger

    def initialize
      @logger = Logger.new(STDOUT)
      logger.formatter = proc { |_, _, _, msg| msg + "\n" }
    end

    def get_user(username)
      url = "https://api.github.com/users/#{username}"

      start_time = Time.now
      response = Faraday.get url
      duration = Time.now - start_time

      logger.debug "-> %s %s %d (%.3f s)" % [url, 'GET', response.status, duration]

      if response.status == 404
        raise NonexistentUser, "'#{username}' doesn't exist."
      end

      data = JSON.parse(response.body)
      User.new(data['name'], data['location'], data['public_repos'])
    end
  end

end
