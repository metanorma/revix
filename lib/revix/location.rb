# frozen_string_literal: true

require "lutaml/model"

module Revix
  class Location < Lutaml::Model::Serializable
    VALID_TYPES = %w[
      section clause part paragraph chapter page line table annex figure
      example note formula list time anchor whole
    ].freeze

    attribute :value, :string
    attribute :type, :string, values: VALID_TYPES

    xml do
      root "location"
      map_content to: :value, value_map: { to: { nil: :empty } }
      map_attribute "type", to: :type
    end

    key_value do
      map "value", to: :value
      map "type", to: :type
    end
  end
end
