require "formalist/element"
require "formalist/types"

module Formalist
  class Elements
    class Field < Element
      attribute :label, Types::String
      attribute :hint, Types::String
      attribute :placeholder, Types::String
      attribute :inline, Types::Bool
      attribute :validation, Types::Validation

      def fill(input: {}, errors: {})
        super(
          input: input[name],
          errors: errors[name].to_a,
        )
      end

      # Converts the field into an abstract syntax tree.
      #
      # It takes the following format:
      #
      # ```
      # [:field, [params]]
      # ```
      #
      # With the following parameters:
      #
      # 1. Field name
      # 2. Custom form element type (or `:field` otherwise)
      # 3. Associated form input data
      # 4. Error messages
      # 5. Form element attributes
      #
      # @see Formalist::Element::Attributes#to_ast "Form element attributes" structure
      #
      # @example "email" field
      #   field.to_ast
      #   # => [:field, [
      #     :email,
      #     :field,
      #     "jane@doe.org",
      #     [],
      #     [:object, []],
      #   ]]
      #
      # @return [Array] the field as an abstract syntax tree.
      def to_ast
        # errors looks like this
        # {:field_name => [["pages is missing", "another error message"], nil]}

        [:field, [
          name,
          type,
          input,
          errors,
          Element::Attributes.new(attributes).to_ast,
        ]]
      end
    end
  end
end
