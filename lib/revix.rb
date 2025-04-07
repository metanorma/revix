# frozen_string_literal: true

require_relative "revix/version"
require "nokogiri"
require "lutaml/model"

module Revix
  class Error < StandardError; end
end

require_relative "revix/name"
require_relative "revix/person"
require_relative "revix/organization"
require_relative "revix/contributor"
require_relative "revix/date_info"
require_relative "revix/classification"
require_relative "revix/location"
require_relative "revix/amendment"
require_relative "revix/revision"
require_relative "revix/revision_history"
