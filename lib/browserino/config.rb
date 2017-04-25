# frozen_string_literal: true
module Browserino
  class Config < Options
    def define(&block)
      instance_eval(&block)

      matchers.each do |matcher|
        properties << matcher.properties.keys
        types      << matcher.type
        names      << matcher.name
      end

      properties.flatten!.uniq!
      types.uniq!
      names.uniq!
    end

    def label(name, **opts)
      return false unless opts[:for]
      opts[:name] ||= name
      labels[opts[:for]] << opts
    end

    def filter(*props, &block)
      props << :global unless props.any?
      props.each { |prop| filters[prop] << block }
    end

    def smart_match(prop, **options)
      smart_matchers[prop] = options if options[:with]
    end

    def match(rgxp = nil, **opts, &block)
      if rgxp.is_a? Hash
        opts = rgxp.dup
        rgxp = nil
      end

      opts = @tmp_defaults.merge opts if @tmp_defaults.is_a? Hash

      if rgxp && opts[:like]
        matchers.unshift with_alias(rgxp, opts, &block)
      elsif rgxp
        matchers << Matcher.new(rgxp, opts, &block).freeze
      else
        global_matchers.unshift Matcher.new(&block).freeze
      end
    end

    def alias_for(name, *names)
      aliasses[name] += names
    end

    def before_parse(&block)
      @options[:before_parse] << block if block
      @options[:before_parse]
    end

    def preset(props, &block)
      @tmp_defaults = props
      instance_eval(&block)
      @tmp_defaults = nil
    end

    def like(tmp, opts = {}, &block)
      preset opts.merge(like: tmp.to_sym), &block
    end

    def validators(opts = {}, &block)
      preset opts.merge(type: :validator), &block
    end

    def browsers(opts = {}, &block)
      preset opts.merge(type: :browser), &block
    end

    def bots(opts = {}, &block)
      preset opts.merge(type: :bot), &block
    end

    def libraries(opts = {}, &block)
      preset opts.merge(type: :library), &block
    end

    def with_alias(pattern, **opts, &block)
      alt = matchers.select { |id| id == opts[:like] }.first

      raise "No alias found for: #{opts[:like] || 'nil'}" unless alt

      base = alt.properties
      if (excl = opts.delete(:except))
        base = base.reject { |k| excl.include? k }
      end

      Matcher.new(pattern, base.merge(opts), &block).freeze
    end
  end
end
