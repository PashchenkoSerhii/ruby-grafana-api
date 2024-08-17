module Grafana

  module Login

    def ping_session()
      endpoint = "/api/login/ping"
      return get_request(endpoint)
    end
  end

end
