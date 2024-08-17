
require 'rest-client'
require 'json'
require 'logger'

module Grafana

  require_relative 'http_request'
  require_relative 'user'
  require_relative 'users'
  require_relative 'datasource'
  require_relative 'organization'
  require_relative 'organizations'
  require_relative 'folder'
  require_relative 'dashboard'
  require_relative 'dashboard_template'
  require_relative 'snapshot'
  require_relative 'frontend'
  require_relative 'login'
  require_relative 'admin'
  require_relative 'version'

  class Client

    attr_reader :debug, :session_cookies, :headers, :logger, :api_instance

    include Grafana::HttpRequest
    include Grafana::User
    include Grafana::Users
    include Grafana::Datasource
    include Grafana::Organization
    include Grafana::Organizations
    include Grafana::Folder
    include Grafana::Dashboard
    include Grafana::DashboardTemplate
    include Grafana::Snapshot
    include Grafana::Frontend
    include Grafana::Login
    include Grafana::Admin

    def initialize(host="localhost", port=3000, user='admin', pass='', url=nil, settings={})

      if settings.has_key?('timeout') && settings['timeout'].to_i <= 0
        settings['timeout'] = 5
      end

      if settings.has_key?('open_timeout') && settings['open_timeout'].to_i <= 0
        settings['open_timeout'] = 5
      end

      if settings.has_key?('headers') && !settings['headers'].kind_of?(Hash)
        settings['headers'] = {}
      end

      if settings.has_key?('url_path') && !settings['url_path'].kind_of?(String)
        settings['url_path'] = ''
      end


      proto = 'https'
      url ||= sprintf( '%s://%s:%s%s', proto, host, port, settings['url_path'] )
      

      @api_instance = RestClient::Resource.new(
        "#{url}",
        :timeout => settings['timeout'],
        :open_timeout => settings['open_timeout'],
        :headers => settings['headers']
      )
      @debug = (settings['debug'] ? true : false)
      @logger = Logger.new(STDOUT)
      @headers = nil

      if settings['headers'].key?('Authorization')
        # API key Auth
        @headers = {
          :content_type => 'application/json; charset=UTF-8',
          :Authorization => settings['headers']['Authorization']
        }
      else
        # Regular login Auth
        self.login(user, pass)
      end
      return self
    end

    def login(user='admin',pass='admin')
      @logger.info("Attempting to establish user session") if @debug
      request_data = {'User' => user, 'Password' => pass}
      begin
        resp = @api_instance['/login'].post(
          request_data.to_json,
          {:content_type => 'application/json; charset=UTF-8'}
        )
        @session_cookies = resp.cookies
        if resp.code.to_i == 200
          @headers = {
            :content_type => 'application/json; charset=UTF-8',
            :cookies => @session_cookies
          }
          return true
        else
          return false
        end
      rescue => e
        @logger.error("Error running POST request on /login: #{e}") if @debug
        @logger.error("Request data: #{request_data.to_json}") if @debug
        return false
      end
      @logger.info("User session initiated") if @debug
    end

  end # End of Client class

end # End of GrafanaApi module
