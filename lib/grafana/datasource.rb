
module Grafana

  module Datasource

    def get_cw_namespaces(datasource_id)
      endpoint = "/api/datasources/proxy/#{datasource_id}"
      return post_request(endpoint, {"action" => "__GetNamespaces"}.to_json)
    end

    def get_data_sources()
      endpoint = "/api/datasources"
      return get_request(endpoint)      
    end 

    def get_data_source_by_id(id)
      endpoint = "/api/datasources/#{id}"
      return get_request(endpoint)
    end

    def update_data_source_by_id(id, ds={})
      existing_ds = self.get_data_source_by_id(id)
      ds = existing_ds.merge(ds)
      endpoint = "/api/datasources/#{id}"
      return put_request(endpoint, ds.to_json)
    end

    def create_data_source(ds={})
      if ds == {} || !ds.has_key?('name') || !ds.has_key?('database')
        puts "key error"
        return false
      end
      endpoint = "/api/datasources"
      return post_request(endpoint, ds.to_json)
    end

    def delete_data_source(id)
      endpoint = "/api/datasources/#{id}"
      return delete_request(endpoint)
    end

    def get_available_data_source_types()
      endpoint = '/api/datasources/plugins'
      return get_request(endpoint)
    end

  end

end
