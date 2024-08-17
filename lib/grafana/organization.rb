
module Grafana

  module Organization

    def get_current_org()
      endpoint = "/api/org"
      return get_request(endpoint)
    end

    def update_current_org(properties={})
      endpoint = "/api/org"
      return put_request(endpoint, properties)
    end

    def get_current_org_users()
      endpoint = "/api/org/users"
      return get_request(endpoint)
    end

    def add_user_to_current_org(properties={})
      endpoint = "/api/org/users"
      return post_request(endpoint, properties)
    end


  end

end
