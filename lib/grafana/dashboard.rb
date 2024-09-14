module Grafana

  module Dashboard

    def create_slug(text)
      text.gsub!(/[()]/, "")
      if text =~ /\s/
        if text =~ /-/
          text = text.gsub(/\s+/, "").downcase
        else
          text = text.gsub(/\s+/, "-").downcase
        end
      end
      return text
    end

    def get_dashboard_list()
      endpoint = "/api/search"
      return get_request(endpoint)
    end

    def get_dashboard_by_uid(uid='')
      uid = self.create_slug(uid)
      endpoint = "/api/dashboards/uid/#{uid}"
      return get_request(endpoint)
    end

    def create_dashboard(properties={})
  endpoint = "/api/dashboards/db"
  dashboard = self.build_template(properties)
  Rails.logger.info "Creating dashboard with properties: #{properties}"
  Rails.logger.info "Sending dashboard data to Grafana: #{dashboard}"
  response = post_request(endpoint, dashboard)
  Rails.logger.info "Dashboard created response: #{response}"
  return response
end

    def update_dashboard(dashboard)
      Rails.logger.info "update_dashboard : #{dashboard.to_json}"
      endpoint = "/api/dashboards/db"
      return post_request(endpoint, dashboard.to_json)
    end

    def delete_dashboard_bu_uid(uid)
      uid = self.create_slug(uid)
      endpoint = "/api/dashboards/uid/#{uid}"
      return delete_request(endpoint)
    end

    def get_home_dashboard()
      endpoint = "/api/dashboards/home"
      return get_request(endpoint)
    end

    def get_dashboard_tags()
      endpoint = "/api/dashboards/tags"
      return get_request(endpoint)
    end

    def search_dashboards(params={})
      Rails.logger.info "Initial parameters: #{params}"

      # Стандартная обработка параметров
      params['query'] = params['query'].presence ? CGI.escape(params['query']) : ''
      params['starred'] = params['starred'].to_s
      params['tags'] = params['tags'].to_s

      # Добавляем фильтр по folderUid, если он есть
      folder_query = params['folderId'].present? ? "&folderIds=#{params['folderId']}" : ''

      # Построение конечного URL для запроса
      endpoint = "/api/search?query=#{params['query']}&starred=#{params['starred']}&tags=#{params['tags']}#{folder_query}"
      Rails.logger.info "Constructed endpoint for search_dashboards: #{endpoint}"

      response = get_request(endpoint)
      Rails.logger.info "Response from search_dashboards: #{response}"

      response
    end
  end

end
