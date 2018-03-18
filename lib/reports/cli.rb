require 'rubygems'
require 'bundler/setup'
require 'thor'

require 'reports/github_api_client'
require 'reports/table_printer'

module Reports

  class CLI < Thor

    desc "console", "Open an RB session with all dependencies loaded and API defined."
    def console
      require 'irb'
      ARGV.clear
      IRB.start
    end

    desc "user_info USERNAME", "Get information for a user"
    def user_info(username)
      puts "Getting user information for #{username}"

      response = Faraday.get "https://api.github.com/users/#{username}"
      data = JSON.parse(response.body)

      puts "Name: #{data['name']}"
      puts "Location: #{data['location']}"
      puts "Public repos: #{data['public_repos']}"
    end

    private

    def client
      @client ||= GitHubAPIClient.new
    end

  end

end