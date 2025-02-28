# frozen_string_literal: true

require "lutaml/model"

module Revix
  class Classification < Lutaml::Model::Serializable
    attribute :tag, :string
    attribute :value, :string

    xml do
      root "classification"
      map_element "tag", to: :tag
      map_element "value", to: :value
    end

    key_value do
      map "tag", to: :tag
      map "value", to: :value
    end
  end
end
