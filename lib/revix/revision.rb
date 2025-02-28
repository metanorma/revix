# frozen_string_literal: true

require "lutaml/model"

module Revix
  class Revision < Lutaml::Model::Serializable
    attribute :date, DateInfo, collection: true
    attribute :edition, :string
    attribute :contributor, Contributor, collection: true
    attribute :amend, Amendment, collection: true
    attribute :relation_type, Amendment, collection: true

    xml do
      root "revision"
      map_element "date", to: :date
      map_element "edition", to: :edition
      map_element "contributor", to: :contributor
      map_element "amend", to: :amend
      map_element "relation", to: :relation_type
    end

    key_value do
      map "date", to: :date
      map "edition", to: :edition
      map "contributor", to: :contributor
      map "amend", to: :amend
      map "relation", to: :relation_type
    end
  end
end
