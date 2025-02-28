# frozen_string_literal: true

require "lutaml/model"

module Revix
  class DateInfo < Lutaml::Model::Serializable
    attribute :type, :string
    attribute :value, :string

    xml do
      root "date"
      map_element "type", to: :type
      map_element "value", to: :value
    end

    key_value do
      map "type", to: :type
      map "value", to: :value
    end
  end
end
