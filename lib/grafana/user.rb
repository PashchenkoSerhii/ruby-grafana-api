
module Grafana

  module User

    def get_current_user()
      endpoint = "/api/user"
      return get_request(endpoint)
    end

    def update_current_user_pass(properties={})
      endpoint = "/api/user/password"
      return put_request(endpoint,properties)
    end

    def switch_current_user_org(org_id)
      endpoint = "/api/user/using/#{org_id}"
      return post_request(endpoint, {})
    end

    def get_current_user_orgs()
      endpoint = "/api/user/orgs"
      return get_request(endpoint)
    end

    def add_dashboard_star(dashboard_id)
      endpoint = "/api/user/stars/dashboard/#{dashboard_id}"
      return post_request(endpoint, {})
    end

    def remove_dashboard_star(dashboard_id)
      endpoint = "/api/user/stars/dashboard/#{dashboard_id}"
      return delete_request(endpoint)
    end

  end

end
