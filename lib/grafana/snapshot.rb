module Grafana

  module Snapshot

    def get_snapshot(key)
      endpoint = "/api/snapshot/#{key}"
      return get_request(endpoint)
    end

    def create_snapshot(dashboard={})
      endpoint = "/api/snapshot"
      return post_request(endpoint, dashboard)
    end

    def delete_snapshot(key)
      endpoint = "/api/snapshots-delete/#{key}"
      return delete_request(endpoint)
    end

  end

end
