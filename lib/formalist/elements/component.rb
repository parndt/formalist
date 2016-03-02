require "formalist/element"
require "formalist/types"

module Formalist
  class Elements
    class Component < Element
      permitted_children :field

      # Converts the section into an array format for including in a form's
      # abstract syntax tree.
      #
      # The array takes the following format:
      #
      # ```
      # [:section, [params]]
      # ```
      #
      # With the following parameters:
      #
      # 1. Section name
      # 1. Section configuration
      # 1. Child form elements
      #
      # @example "content" section
      #   section.to_ast # =>
      #   # [:section, [
      #   #   :content,
      #   #   [
      #   #     [:some_config_name, :some_config_value]
      #   #   ],
      #   #   [
      #   #     ...child elements...
      #   #   ]
      #   # ]]
      #
      # @return [Array] the section as an array.
      def to_ast
        [:component, [
          type,
          attributes.to_a,
          children.map(&:to_ast),
        ]]
      end
    end
  end
end