module Grafana
  module Folder
    # Получение списка папок
    def get_folders
      endpoint = '/api/folders'
      Rails.logger.info "Getting folders with endpoint: #{endpoint}"
      response = get_request(endpoint)
      Rails.logger.info "Response from get_folders: #{response}"
      response
    end

    # Получение папки по UID
    def get_folder_by_uid(uid='')
      endpoint = "/api/folders/#{uid}"
      Rails.logger.info "Getting folder by UID with endpoint: #{endpoint}"
      response = get_request(endpoint)
      Rails.logger.info "Response from get_folder_by_uid: #{response}"
      response
    end
    
    # Создание папки
    def create_folder(properties={})
      endpoint = "/api/folders"
      Rails.logger.info "Properties for create_folder: #{properties}"
      folder_data = {
        "title" => properties['title'],
        "parentUid" => properties['parentUid']
      }.compact
      Rails.logger.info "Sending data to Grafana for create_folder: #{folder_data}"
      response = post_request(endpoint, folder_data.to_json)
      Rails.logger.info "Response from create_folder: #{response}"
      response
    end

    # Обновление папки
    def update_folder(uid='', properties={})
      endpoint = "/api/folders/#{uid}"
       Rails.logger.info "endpoint for update_folder: #{endpoint}"
      Rails.logger.info "Properties for update_folder: #{properties}"
      folder_data = {
        "title" => properties['title'],
        "version" => properties['version'],
        "overwrite" => properties['overwrite']
      }.compact
      Rails.logger.info "Sending data to Grafana for update_folder: #{folder_data}"
      response = put_request(endpoint, folder_data.to_json)
      Rails.logger.info "Response from update_folder: #{response}"
      response
    end

    # Удаление папки по UID
    def delete_folder_by_uid(uid='', forceDeleteRules=false)
      endpoint = "/api/folders/#{uid}?forceDeleteRules=#{forceDeleteRules}"
      Rails.logger.info "Sending request to delete folder: #{endpoint}"
      response = delete_request(endpoint)
      Rails.logger.info "Response from delete_folder_by_uid: #{response}"
      response
    end

    # Перемещение папки
    def move_folder(uid='', parentUid=nil)
      endpoint = "/api/folders/#{uid}/move"
      Rails.logger.info "Sending request to move folder: #{endpoint}"
      move_data = { "parentUid" => parentUid }.compact
      Rails.logger.info "Sending data to move folder: #{move_data}"
      response = post_request(endpoint, move_data.to_json)
      Rails.logger.info "Response from move_folder: #{response}"
      response
    end
  end
end
