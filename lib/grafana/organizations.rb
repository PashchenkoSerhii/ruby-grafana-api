
module Grafana

  module Organizations

    def get_all_orgs()
      endpoint = "/api/orgs"
      return get_request(endpoint)
    end


    def update_org(org_id, properties={})
      endpoint = "/api/orgs/#{org_id}"
      return post_request(endpoint, properties)
    end

    def get_org_users(org_id)
      endpoint = "/api/orgs/#{org_id}/users"
      return get_request(endpoint)
    end


    def add_user_to_org(org_id, user={}) 
      endpoint = "/api/orgs/#{org_id}/users"
      return post_request(endpoint, user)
    end

    def update_org_user(org_id, user_id, properties={})
      endpoint = "/api/orgs/#{org_id}/users/#{user_id}"
      return patch_request(endpoint, properties)
    end

    def delete_user_from_org(org_id, user_id)
      endpoint = "/api/orgs/#{org_id}/users/#{user_id}"
      return delete_request(endpoint)
    end

  end

end
