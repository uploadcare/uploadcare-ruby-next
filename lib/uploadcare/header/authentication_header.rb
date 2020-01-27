# frozen_string_literal: true

require 'digest/md5'

module Uploadcare
  # This class is essentially a semaphore object,
  # deciding which authentication mechanism to use
  # https://uploadcare.com/docs/api_reference/rest/requests_auth/#auth-uploadcare
  class AuthenticationHeader
    def self.call(**options)
      case AUTH_TYPE
      when 'Uploadcare'
        SecureAuthHeader.call(options)
      when 'Uploadcare.Simple'
        SimpleAuthHeader.call
      else
        raise ArgumentError, "Unknown auth_scheme: '#{AUTH_TYPE}'"
      end
    end
  end
end
