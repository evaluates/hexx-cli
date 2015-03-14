# encoding: utf-8
require "extlib"

module Hexx

  module CLI

    # Decorates a string with conventional names
    class Name

      # @!scope class
      # @!method new(string)
      # Constructs the parser object
      #
      # @example
      #   Hexx::CLI::Name.new "MyGem::MyClass.methods.chain"
      #
      # @param  [#to_s] string
      #   The string to be parsed
      #
      # @return [Hexx::CLI::Name]
      def initialize(string)
        @list = string.to_s.snake_case.gsub(/\:{2}|-/, "/").split(".")
      end

      # Returns the last part of the singular name
      #
      # @example
      #   source = "cats-wildcats/jaguars::PantherTiger.bite"
      #   name = Hexx::CLI::Name.new(source)
      #   name.item
      #   # => "panther_tiger"
      #
      # @return [String]
      def item
        @item ||= snakes.last.to_s.singular
      end

      # Returns the last part of the plural name
      #
      # @example
      #   source = "cats-wildcats/jaguars::PantherTiger.bite"
      #   name = Hexx::CLI::Name.new(source)
      #   name.items
      #   # => "panther_tigers"
      #
      # @return [String]
      def items
        @items ||= item.plural
      end

      # Returns the dashes-delimited name
      #
      # @example
      #   source = "cats-wildcats/jaguars::PantherTiger.bite"
      #   name = Hexx::CLI::Name.new(source)
      #   name.file
      #   # => "cats-wildcats-jaguars-panther_tiger.bite"
      #
      # @return [String]
      def file
        @file ||= [snakes.join("-"), method].compact.join(".")
      end

      # Returns the slash-delimited name
      #
      # @example
      #   source = "cats-wildcats/jaguars::PantherTiger.bite"
      #   name = Hexx::CLI::Name.new(source)
      #   name.path
      #   # => "cats/wildcats/jaguars/panther_tiger/bite"
      #
      # @return [String]
      def path
        @path ||= [snakes.join("/"), method].compact.join(".")
      end

      # Returns the name as a full constant
      #
      # @example
      #   source = "cats-wildcats/jaguars::PantherTiger.bite"
      #   name = Hexx::CLI::Name.new(source)
      #   name.type
      #   # => "Cats::Wildcats::Jaguars::PantherTiger.bite"
      #
      # @return [String]
      def type
        @type ||= [camels.join("::"), method].compact.join(".")
      end

      # Returns the name as a last part of constant
      #
      # @example
      #   source = "cats-wildcats/jaguars::PantherTiger.bite"
      #   name = Hexx::CLI::Name.new(source)
      #   name.const
      #   # => "PantherTiger.bite"
      #
      # @return [String]
      def const
        @const ||= [camels.last, method].compact.join(".")
      end

      # Returns the array of namespaces (module names) for the constant
      #
      # @example
      #   source = "cats-wildcats/jaguars::PantherTiger.bite"
      #   name = Hexx::CLI::Name.new(source)
      #   name.namespaces
      #   # => ["Cats", "Wildcats", "Jaguars"]
      #
      # @return [Array<String>]
      def namespaces
        @namespaces ||= camels[0..-2]
      end

      private

      # String of chained methods
      #
      # @return [String]
      # @return [nil]
      #   if source has no methods
      #
      # @api private
      def method
        @method ||= @list[1..-1] if @list.count > 1
      end

      # List of snake-cased parts of the constant
      #
      # @return [Array<String>]
      #
      # @api private
      def snakes
        @snakes ||= @list.first.to_s.split("/")
      end

      # List of camel-cased parts of the constant
      #
      # @return [Array<String>]
      #
      # @api private
      def camels
        @camels ||= snakes.map(&:camel_case)
      end

    end # class Name

  end # module CLI

end # module Hexx
