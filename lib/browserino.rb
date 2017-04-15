# frozen_string_literal: true
require_relative 'browserino/methods'
require_relative 'browserino/agent'
require_relative 'browserino/identity'

require_relative 'browserino/agent/version'

require_relative 'browserino/definitions/lies'
require_relative 'browserino/definitions/defaults'
require_relative 'browserino/definitions/detectors'
require_relative 'browserino/definitions/formatters'

module Browserino
  def self.parse(ua)
    before_parse.each { |b| b.call ua } if before_parse.any?
    identities.each do |_, identity|
      return analyze ua, identity if identity.matches? ua
    end

    analyze ua
  end
end
