# frozen_string_literal: true

module Uploadcare
  module Client
    # @abstract
    #
    # Headers and helper methods for clients working with upload API
    # @see https://uploadcare.com/docs/api_reference/upload/
    class UploadClient < ApiStruct::Client
      include Concerns::ErrorHandler
      include Concerns::ThrottleHandler
      include Exception
      upload_api
    end
  end
end
