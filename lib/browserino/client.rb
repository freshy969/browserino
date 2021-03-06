# frozen_string_literal: true

module Browserino
  class Client
    def initialize(props = {}, like = nil)
      @property_names = props.keys
      @like           = like

      # properties are added as methods that will each be defined in a specific
      # order below. First, seperate static value methods from procs,
      # procs will be able to call methods in this instances' context
      # therefore we need to define static methods before procs
      generate_preset_methods! props

      # for each of #name, #engine, #platform and #device use their results as
      # methods names, this will create a method #firefox? for the output
      # of a #name # => :firefox for example.
      # NOTE: labels do not have to be added, they will be extracted
      # and inserted by this method, this method will also add aliasses
      # of all the names as methods.
      generate_result_methods! props, :name, :engine, :platform, :device
      generate_proc_methods! props
    end

    def properties
      @properties ||= @property_names.each_with_object({}) do |prop, result|
        result[prop] = send prop
      end
    end

    def like
      @like ||= self
    end

    def like?(sym, opts = {})
      invertable like.is?(sym, opts)
    end

    def x64?
      invertable(@x64 ||= architecture == :x64)
    end

    def x32?
      invertable(@x32 ||= architecture == :x32)
    end

    def arm?
      invertable(@arm ||= architecture == :arm)
    end

    def is?(sym, opt = {})
      return invertable send("#{sym}?", opt[:version]) if opt && opt[:version]

      invertable send("#{sym}?")
    end

    def not?(sym, opts = {})
      !is? sym, opts
    end

    def ===(other)
      return invertable false unless name

      invertable case other
                 when Regexp         then other        =~ name
                 when String         then other.to_sym == name
                 when Symbol, Client then other        == name
                 else false
                 end
    end

    def ==(other)
      self === other
    end

    def =~(other)
      self === other
    end

    def to_str
      to_s
    end

    def to_json(*args)
      @to_json ||= properties.each_with_object({}) do |(prop, val), hsh|
        hsh[prop] = val.is_a?(Version) && val.full || val
      end.to_json(*args)
    end

    def label_or_version_name(prop)
      ver = version_for prop
      label_for(prop) || ver && [properties[prop].to_s.strip,
                                 (ver.major if ver > '0.0.0')].join.strip
    end

    def to_s
      @to_s ||= %i[name engine platform device].each_with_object([]) do |pr, a|
        a << properties[pr].to_s.strip
        a << label_or_version_name(pr)
      end.compact.reject(&:empty?).uniq.join ' '
    end

    def to_hash
      properties
    end

    def to_h
      properties
    end

    def to_a
      properties.to_a
    end

    # scary, I know, but a falsy value is all we need to return if some
    # property isn't known as any property can be defined on the Client
    def method_missing(*)
      invertable nil
    end

    # always respond to missing, read method_missing comment
    def respond_to_missing?(*)
      true
    end

    # if you wish for a method to respond to the #not method,
    # you'll have to return the result of a function using the `invertable`
    # method as seen in `method_missing` - this will apply the state of the
    # instance variable and invert the state as well as the result if set,
    # otherwise it will just return the value without touching it
    def not
      @not = true && self
    end

    private

    def invertable(result)
      @not ? @not = false || !result : result
    end

    def label_for(sym, from = properties)
      return from[:label] if %i[version label name].include? sym

      from["#{sym}_label".to_sym]
    end

    def name_for(sym, from = properties)
      return from[:name] if %i[version label name].include? sym

      from["#{sym}_name".to_sym]
    end

    def version_for(sym, from = properties)
      return from[:version] if %i[version label name].include? sym

      from["#{sym}_version".to_sym]
    end

    def generate_preset_methods!(props)
      props.each do |name, value|
        methods = [name, *Browserino.config.aliasses[name]]
        methods.each do |mtd|
          define_singleton_method(mtd) { value }
          define_singleton_method("#{mtd}?") do |val = nil, opts = {}|
            if val && opts.key?(:version)
              value == val && version_for(name) == opts[:version]
            elsif val
              value == val
            else value && true
            end
          end
        end
      end
    end

    def generate_proc_methods!(props)
      props.select { |_, val| val.respond_to? :call }.each do |name, value|
        result = instance_eval(&value)
        define_singleton_method(name)       { invertable result }
        define_singleton_method("#{name}?") { invertable result && true }
      end
    end

    def generate_result_methods!(info, *property_names)
      property_names.each do |prop|
        ver_res = version_for prop, info

        create_question! info[prop],            version: ver_res, aliasses: true
        create_question! label_for(prop, info), version: ver_res, aliasses: true
      end
    end

    def create_question!(result, opts = {})
      methods = [result]
      methods += Browserino.config.aliasses[result] if opts[:aliasses]

      methods.each do |mtd|
        define_singleton_method("#{mtd}?") do |val = nil|
          invertable(val ? opts[:version] == val : true)
        end
      end
    end
  end
end
