# frozen_string_literal: true

require 'spec_helper'
require 'param/simple_auth_header'

module Uploadcare
  RSpec.describe Param::SimpleAuthHeader do
    subject { Uploadcare::Param::SimpleAuthHeader }
    describe 'Uploadcare.Simple' do
      before do
        Uploadcare.configuration.public_key = 'foo'
        Uploadcare.configuration.secret_key = 'bar'
        Uploadcare.configuration.auth_type = 'Uploadcare.Simple'
      end

      it 'returns correct headers for simple authentication' do
        expect(subject.call).to eq('Authorization': 'Uploadcare.Simple foo:bar')
      end
    end
  end
end
