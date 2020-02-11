# frozen_string_literal: true

module Uploadcare
  # This is client for general uploads
  # https://uploadcare.com/api-refs/upload-api/#tag/Upload
  class UploadClient < ApiStruct::Client
    upload_api

    def upload(object, store: false)
      if file?(object)           then upload_many([object], store: store)
      elsif object.is_a?(Array)  then upload_many(object, store: store)
      else
        raise ArgumentError, "Expected input to be a file/Array/URL, given: `#{object}`"
      end
    end

    # https://uploadcare.com/api-refs/upload-api/#operation/baseUpload

    def upload_many(arr, store: false)
      body = HTTP::FormData::Multipart.new(
        upload_params(store).merge(files_formdata(arr))
      )
      post(path: 'base/',
           headers: { 'Content-type': body.content_type },
           body: body)
    end

    private

    def upload_params(store = false)
      {
        'UPLOADCARE_PUB_KEY': PUBLIC_KEY,
        'UPLOADCARE_STORE': (store == true) ? '1' : '0'
      }
    end

    def files_formdata(arr)
      arr.map { |file| [HTTP::FormData::File.new(file).filename,
                        HTTP::FormData::File.new(file)] }.to_h
    end

    def file?(object)
      object.respond_to?(:path) && ::File.exist?(object.path)
    end
  end
end
