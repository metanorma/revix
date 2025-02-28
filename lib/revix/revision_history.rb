# frozen_string_literal: true

require "lutaml/model"

module Revix
  class RevisionHistory < Lutaml::Model::Serializable
    attribute :revisions, Revix::Revision, collection: true

    xml do
      root "revision-history"
      map_element "revision", to: :revisions
    end

    key_value do
      map "revisions", to: :revisions
    end
  end
end
