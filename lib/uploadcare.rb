# frozen_string_literal: true

Gem.find_files('ruby/**/*.rb').each { |path| require path }
Gem.find_files('exception/**/*.rb').each { |path| require path }
require 'api_struct'
require 'dry-configurable'
require 'api_struct_settings'
require 'uploadcare_configuration'
require 'default_configuration'
require 'entity/entity'
Gem.find_files('entity/**/*.rb').each { |path| require path }
require 'api/api'

# Ruby wrapper for Uploadcare API
#
# @see https://uploadcare.com/docs/api_reference
module Uploadcare
end
