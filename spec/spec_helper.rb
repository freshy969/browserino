$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'pry'
require 'coveralls'
Coveralls.wear!

require 'browserino'

module Library
  def self.data
    @data ||= begin
      paths = Dir[File.expand_path('files/*.yml', File.dirname(__FILE__))]
      paths.each_with_object({}) do |path, data|
        subject = path.split('/').last.split('.').first.to_sym
        data[subject] = YAML.load_file(path)[subject]
      end
    end
  end

  def self.random_user_agent(type = :browsers)
    data[type].sample[:user_agent]
  end
end
