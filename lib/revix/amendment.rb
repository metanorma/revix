# frozen_string_literal: true

require "lutaml/model"

module Revix
  class Amendment < Lutaml::Model::Serializable
    attribute :description, :string
    attribute :location, Location, collection: true
    attribute :classification, Classification, collection: true
    attribute :change, :string, default: -> { "modify" }

    xml do
      root "amend"
      map_element "description", to: :description
      map_element "location", to: :location
      map_element "classification", to: :classification
      map_element "change", to: :change
    end

    key_value do
      map "description", to: :description
      map "location", to: :location
      map "classification", to: :classification
      map "change", to: :change
    end
  end
end
