# encoding: utf-8
require "thor"

module Hexx

  module CLI

    require_relative "base/file"
    require_relative "base/folder"

    # Base class for scaffolders
    #
    # Adds actions to the generator
    #
    # @example (see #from_template)
    # @example (see #copy_folder)
    class Base < Thor::Group
      include Thor::Actions

      private

      # Returns source root defined for the class
      #
      # @return [String, Array<String>]
      def source_root
        self.class.send :source_root
      end

      # Returns content of source (relative to source root), preprocessed by ERB
      #
      # @example
      #   # source_root/file.erb
      #   <%= 2 * 2 %>
      #
      #   scaffolder = Hexx::CLI::Base.new
      #   scaffolder.send :from_template, "file.erb"
      #   # => "4"
      #
      # @return [#to_s] source
      #
      # @api public
      def from_template(source)
        path    = find_in_source_paths(source)
        content = ::File.read(path)
        context = instance_eval("binding")
        ERB.new(content, nil, "-").result(context)
      end

      # Copies files from source folder into the destination one
      #
      # Wherein:
      #
      # * Files with '.erb' extension are preprocessed by ERB.
      #   They saved under initial names without '.erb' extension.
      #
      # * The underscore symbol "_" in the beginning of filename is removed.
      #   You can copy dotfiles by underscoring them.
      #
      # @example
      #   scaffolder = Hexx::CLI::Base.new
      #
      #   scaffolder.copy_folder "root", "spec", skip: true
      #   # root/_.settings         --> spec/.settings
      #   # root/spec_helper.rb.erb --> spec/spec_helper.rb
      #   # root/tests/test_spec.rb --> spec/tests/test_spec.rb
      #
      # @return [undefined]
      #
      # @api public
      def copy_folder(source, target = source, options = {})
        Folder.new(self).copy(source, target, options)
      end

    end # class Base

  end # module CLI

end # module Hexx
