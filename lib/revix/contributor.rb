# frozen_string_literal: true

require "lutaml/model"

module Revix
  class Contributor < Lutaml::Model::Serializable
    attribute :person, Person
    attribute :organization, Organization

    xml do
      root "contributor"
      map_element "person", to: :person
      map_element "organization", to: :organization
    end

    key_value do
      map "person", to: :person
      map "organization", to: :organization
    end
  end
end
