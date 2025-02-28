# frozen_string_literal: true

require "lutaml/model"

module Revix
  class Organization < Lutaml::Model::Serializable
    attribute :name, :string
    attribute :subdivision, :string
    attribute :abbreviation, :string

    xml do
      root "organization"
      map_element "name", to: :name
      map_element "subdivision", to: :subdivision
      map_element "abbreviation", to: :abbreviation
    end

    key_value do
      map "name", to: :name
      map "subdivision", to: :subdivision
      map "abbreviation", to: :abbreviation
    end
  end
end
