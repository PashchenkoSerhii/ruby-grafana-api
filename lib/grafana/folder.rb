module Grafana
  module Folder

    def get_folders
      endpoint = '/api/folders'
      return get_request(endpoint)
    end

    def get_folder_by_uid(uid='')
      endpoint = "/api/folders/#{uid}"
      return get_request(endpoint)
    end
    
    def create_folder(properties={})
      endpoint = "/api/folders"
      Rails.logger.info "properties: #{properties}"
      folder_data = {
        "title" => properties['title'],
        "parentUid" => properties['parentUid']
      }.compact # Удалить nil-поля
      Rails.logger.info "Sending data to Grafana: #{folder_data}"
      response = post_request(endpoint, folder_data.to_json)
      if response.success?
        Rails.logger.info "Folder created successfully: #{response.body}"
      else
        Rails.logger.error "Failed to create folder: #{response.status} #{response.body}"
      end
      return response
    end

    def update_folder(uid='', properties={})
      endpoint = "/api/folders/#{uid}"
      folder_data = {
        "title" => properties['title'],
        "version" => properties['version'],
        "overwrite" => properties['overwrite']
      }.compact
      return put_request(endpoint, folder_data.to_json)
    end

    def delete_folder_by_uid(uid='', forceDeleteRules=false)
      endpoint = "/api/folders/#{uid}?forceDeleteRules=#{forceDeleteRules}"
      return delete_request(endpoint)
    end


    def move_folder(uid='', parentUid=nil)
      endpoint = "/api/folders/#{uid}/move"
      move_data = { "parentUid" => parentUid }.compact
      return post_request(endpoint, move_data.to_json)
    end






  end
end
