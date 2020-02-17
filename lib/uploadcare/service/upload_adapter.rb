# frozen_string_literal: true

require 'concerns/request_error'

module Uploadcare
  # This object decides which of upload methods to use.
  # Returns either file or array of files
  class UploadAdapter
    def self.call(object, **options)
      case
      when big_file?(object)
        upload_big_file(object, **options)
      when file?(object)
        upload_file(object, **options)
      when object.is_a?(Array)
        upload_files(object, **options)
      when object.is_a?(String)
        upload_from_url(object, **options)
      else
        raise ArgumentError, "Expected input to be a file/Array/URL, given: `#{object}`"
      end
    end

    private

    def self.upload_file(object, **options)
      response = UploadClient.new.upload_many([object], **options)
      handle_upload_errors(response)
      File.info(response.success.to_a.flatten[-1])
    end

    def self.upload_files(object, **options)
      response = UploadClient.new.upload_many(object, **options)
      handle_upload_errors(response)
      Hashie::Mash.new(files: response.success.map { |pair| { original_filename: pair[0], uuid: pair[1] } })
    end

    def self.upload_big_file(object, **options)
      response = MultipartUploadClient.new.upload(object)
      handle_upload_errors(response)
      File.new(response.success)
    end

    def self.file?(object)
      object.respond_to?(:path) && ::File.exist?(object.path)
    end

    def self.big_file?(object)
      file?(object) && object.size >= MULTIPART_SIZE_THRESHOLD
    end

    def self.handle_upload_errors(response)
      error = response.success[:error]
      raise(RequestError, error[:content]) if error
    end
  end
end
