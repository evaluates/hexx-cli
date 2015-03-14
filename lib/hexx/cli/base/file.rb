# encoding: utf-8
require "pathname"

module Hexx

  module CLI

    # Utilities to copy files and folders in a scaffolder context
    class Base < Thor::Group

      # Copies a file from a source path to the target folder
      #
      # * Files, that have '.erb' extension, are pre-processed as erb templates.
      # * The starting "_" symbol is removed from a file name.
      #
      # @api private
      class File

        # @!scope class
        # @!method new(scaffolder, source, target, options = {})
        # Constructs the processor for given scaffolder, source and target paths
        #
        # @param [Thor::Actions] scaffolder
        #   the decorated scaffolder
        # @param [Pathname] source
        #   the source folder path to take file from
        # @param [Pathname] target
        #   the target folder path to copy file to
        # @param [Hash] options
        #   the list of options to copy file
        #
        # @return [Hexx::Processors::File]
        def initialize(scaffolder, source, target, options = {})
          @__scaffolder__ = scaffolder
          @source  = source
          @target  = target
          @options = options
        end

        # Makes a copy of given source file
        #
        # @param  [Pathname] source_file
        #
        # @return [self] itself
        def copy(source_file)
          @source_file = source_file
          __scaffolder__.send(copy_method, source_path, target_path, options)

          self
        end

        private

        attr_reader :__scaffolder__, :source, :target, :options, :source_file

        def source_root
          @source_root ||= Pathname.new __scaffolder__.send(:source_root)
        end

        def copy_method
          (source_file.extname == ".erb") ? :template : :copy_file
        end

        def source_path
          source_file.relative_path_from(source_root).to_s
        end

        def target_path
          (target_dirname + target_filename).to_s
        end

        def target_dirname
          target + source_file.relative_path_from(source).dirname
        end

        def target_filename
          basename = source_file.basename(".erb").to_s
          basename[0] == "_" ? basename[1..-1].to_s : basename
        end

      end # class File

    end # class Base

  end # module CLI

end # module Hexx
