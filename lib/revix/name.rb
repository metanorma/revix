# frozen_string_literal: true

require "lutaml/model"

module Revix
  class Name < Lutaml::Model::Serializable
    attribute :abbreviation, :string
    attribute :completename, :string

    xml do
      root "name"
      map_element "abbreviation", to: :abbreviation
      map_element "completename", to: :completename
    end

    key_value do
      map "abbreviation", to: :abbreviation
      map "completename", to: :completename
    end
  end
end
