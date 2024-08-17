
module Grafana

  module Admin

    def get_admin_settings()
      endpoint = "/api/admin/settings"
      return get_request(endpoint)
    end

    def update_user_permissions(id, perm)

      valid_perms = ['Viewer','Editor','Read Only Editor','Admin']

      if perm.kind_of?(String) && !valid_perms.include?(perm)
        @logger.warn("Basic user permissions include: #{valid_perms.join(',')}") if @debug
        return false
      elsif perm.kind_of?(Hash) &&
        ( !perm.has_key?('isGrafanaAdmin') || ![true,false].include?(perm['isGrafanaAdmin']) )
        @logger.warn("Grafana admin permission must be either true or false") if @debug
        return false
      end

      if perm.kind_of? Hash
        endpoint = "/api/admin/users/#{id}/permissions"
        return put_request(endpoint, {"isGrafanaAdmin" => perm['isGrafanaAdmin']}.to_json)
      else
        org = self.get_current_org()
        endpoint = "/api/orgs/#{org['id']}/users/#{id}"
        @logger.info("Updating user ID #{id} permissions (PUT #{endpoint})") if @debug
        user = { 
          'name' => org['name'], 
          'orgId' => org['id'], 
          'role' => perm.downcase.capitalize
        }
        return patch_request(endpoint, user.to_json)
      end
    end

    def delete_user(user_id)
      
      return false if user_id == 1      
      endpoint = "/api/admin/users/#{user_id}"
      return delete_request(endpoint)
    end

    def create_user(properties={})
      endpoint = "/api/admin/users"
      return post_request(endpoint, properties.to_json)
    end

    def update_user_pass(user_id,password)
      endpoint = " /api/admin/users/#{user_id}/#{password}"
      return put_request(endpoint,properties)
    end


  end

end
