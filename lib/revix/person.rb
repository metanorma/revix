# frozen_string_literal: true

require "lutaml/model"

module Revix
  class Person < Lutaml::Model::Serializable
    attribute :name, Name

    xml do
      root "person"
      map_element "name", to: :name
    end

    key_value do
      map "name", to: :name
    end
  end
end
