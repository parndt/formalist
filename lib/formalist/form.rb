require "dry-configurable"
require "formalist/definition_compiler"
require "formalist/display_adapters"
require "formalist/form/definition"
require "formalist/form/result"

module Formalist
  class Form
    extend Dry::Configurable
    extend Definition

    setting :display_adapters, DisplayAdapters

    def self.display_adapters
      config.display_adapters
    end

    # @api private
    def self.elements
      @__elements__ ||= []
    end

    # @api private
    attr_reader :elements

    # @api private
    attr_reader :schema

    def initialize(schema: nil)
      definition_compiler = DefinitionCompiler.new(self.class.display_adapters)
      @elements = definition_compiler.call(self.class.elements)
      @schema = schema
    end

    def call(input, validate: true)
      if validate && schema
        rules = schema.rules.map(&:to_ary)
        errors = schema.(input).messages
      else
        rules = []
        errors = {}
      end

      Result.new(elements.map { |el| el.(input, rules, errors) })
    end
  end
end
