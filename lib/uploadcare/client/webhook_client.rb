# frozen_string_literal: true

# https://uploadcare.com/api-refs/rest-api/v0.5.0/#tag/Webhook

module Uploadcare
  # client for webhook management
  class WebhookClient < ApiStruct::Client
    rest_api

    # Create webhook
    # https://uploadcare.com/docs/api_reference/rest/webhooks/#subscribe

    def create(target_url, event: 'file.uploaded', is_active: true)
      body = { 'target_url': target_url, 'event': event, 'is_active': is_active }.to_json
      headers = AuthenticationHeader.call(method: 'POST', uri: '/webhooks/', content: body)
      post(path: 'webhooks/', headers: headers, body: body)
    end
    # Returns array (not paginated list) of webhooks
    # https://uploadcare.com/docs/api_reference/rest/webhooks/#get-list

    def list
      headers = AuthenticationHeader.call(method: 'GET', uri: '/webhooks/')
      get(path: 'webhooks/', headers: headers)
    end

    # https://uploadcare.com/docs/api_reference/rest/webhooks/#unsubscribe

    def delete(name)
      body = { 'name': name }.to_json
      headers = AuthenticationHeader.call(method: 'POST', uri: '/webhooks/unsubscribe/', content: body)
      post(path: 'webhooks/unsubscribe/', headers: headers, body: body)
    end

    # https://uploadcare.com/docs/api_reference/rest/webhooks/#subscribe-update

    def update(id, **options)
      body = options.to_json
      headers = AuthenticationHeader.call(method: 'POST', uri: "/webhooks/#{id}/", content: body)
      post(path: "webhooks/#{id}/", headers: headers, body: body)
    end
  end
end
