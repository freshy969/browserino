# frozen_string_literal: true
require_relative 'browserino/agent'
require_relative 'browserino/collector'
require_relative 'browserino/identity'

module Browserino
  def self.parse(user_agent)
    before_parse.each { |b| b.call user_agent } if before_parse.any?
    identities.each do |name, identity|
      if identity.matches? user_agent
        return analyze identity, user_agent
      end
    end
    return analyze user_agent
  end

  def self.analyze(identity, user_agent)
    base = @general_collector&.properties.dup || {}
    base.merge! identity.collectable.properties

    properties = base.each_with_object({}) do |(prop, pattern), result|
      match = pattern.match user_agent
      result[prop] = match && match[1]
    end

    Agent.new identity, properties
  end

  def self.define(&block)
    @tmp_identities = []

    module_eval(&block)

    @tmp_identities.each do |identity|
      property_names << identity.collectable.properties.keys
      identities[identity.name] = identity
    end

    @property_names.uniq!.flatten!
  end

  def self.always(&block)
    (@general_collector ||= Collector.new).define_collectors(&block)
  end

  def self.before_parse(&block)
    @before_parse ||= []
    @before_parse << block if block
    @before_parse
  end

  def self.match(pattern, &block)
    @tmp_identities << Identity.new(pattern, &block)
  end

  def self.match_alias(pattern, **opts)
    id = @tmp_identities.select { |id| id == opts[:to] }.first

    raise "No alias found for: #{opts[:to] || 'nil'}" unless id

    definition = Identity.new(pattern) do
      name      opts[:name] || id.name
      type      opts[:type] || id.type
      collector opts[:collector] || id.collector
      alias_of  id.name
    end

    @tmp_identities << definition
  end

  def self.property_names
    @property_names ||= []
  end

  def self.identities
    @identities ||= {}
  end
end
