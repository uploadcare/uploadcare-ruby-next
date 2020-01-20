# frozen_string_literal: true

module Uploadcare
  # API client for handling single files
  # https://uploadcare.com/docs/api_reference/rest/accessing_files/
  # https://uploadcare.com/api-refs/rest-api/v0.5.0/#tag/File
  class FileClient < ApiStruct::Client
    rest_api 'files'

    # Acquire file info
    # https://uploadcare.com/api-refs/rest-api/v0.5.0/#operation/fileInfo

    def info(uuid)
      headers = AuthenticationHeader.call(method: 'GET', uri: "/files/#{uuid}/")
      response = get(path: "files/#{uuid}/", headers: headers)
    end

    # 'copy' method is used to copy original files or their modified versions to default storage.
    # Source files MAY either be stored or just uploaded and MUST NOT be deleted.
    # https://uploadcare.com/api-refs/rest-api/v0.5.0/#operation/copyFile

    def copy(**options)
      body = options.to_json
      headers = AuthenticationHeader.call(method: 'POST', uri: '/files/',
        content: body)
      post(path: 'files/', headers: headers, body: body)
    end

    alias _delete delete

    # https://uploadcare.com/api-refs/rest-api/v0.5.0/#operation/deleteFile

    def delete(uuid)
      headers = AuthenticationHeader.call(method: 'DELETE', uri: "/files/#{uuid}/")
      _delete(path: "files/#{uuid}/", headers: headers)
    end

    # Store a single file, preventing it from being deleted in 2 weeks
    # https://uploadcare.com/api-refs/rest-api/v0.5.0/#operation/storeFile

    def store(uuid)
      headers = AuthenticationHeader.call(method: 'PUT', uri: "/files/#{uuid}/storage/")
      put(path: "files/#{uuid}/storage/", headers: headers)
    end
  end
end
