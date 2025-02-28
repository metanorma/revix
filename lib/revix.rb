# frozen_string_literal: true

require_relative "revix/version"
require "lutaml/model"

module Revix
  class Error < StandardError; end
end

require_relative "revix/name"
require_relative "revix/person"
require_relative "revix/organization"
require_relative "revix/contributor"
require_relative "revix/date_info"
require_relative "revix/classification"
require_relative "revix/location"
require_relative "revix/amendment"
require_relative "revix/revision"
require_relative "revix/revision_history"

require "lutaml/model/xml_adapter/nokogiri_adapter"
require "lutaml/model/json_adapter/standard_json_adapter"
require "lutaml/model/yaml_adapter/standard_yaml_adapter"

Lutaml::Model::Config.configure do |config|
  config.xml_adapter = Lutaml::Model::XmlAdapter::NokogiriAdapter
  config.yaml_adapter = Lutaml::Model::YamlAdapter::StandardYamlAdapter
  config.json_adapter = Lutaml::Model::JsonAdapter::StandardJsonAdapter
end
