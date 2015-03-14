module Hexx

  module CLI

    class Base < Thor::Group

      # Copies all files from a source folder to the target one
      #
      # * Files, that have '.erb' extension, are pre-processed as erb templates.
      # * The starting "_" symbol is removed from a file name.
      #
      # @api private
      class Folder

        # @!scope class
        # @!method new(scaffolder)
        # Constructs the processor for given scaffolder
        #
        # @param [Thor::Actions] scaffolder
        #
        # @return [Hexx::Processors::Folder]
        def initialize(scaffolder)
          @__scaffolder__ = scaffolder
        end

        # Copies a source folder content to the target folder
        #
        # @param  [String] source
        #   The source folder path relative to the scaffolder's source_root
        # @param  [String] target
        #   The target folder path relative to the scaffolder's destination_root
        # @param  [Hash] options
        #
        # @return [self] itself
        def copy(source, target, options = {})
          @source, @target, @options = source, target, options
          source_files.each { |file| file_processor.copy(file) }

          self
        end

        private

        attr_reader :__scaffolder__, :source, :target, :options

        def source_files
          source_paths.map(&Pathname.method(:new)).select(&:file?)
        end

        def file_processor
          File.new __scaffolder__, source_folder, target_folder, options
        end

        def source_paths
          ::Dir[source_folder + "**/*"]
        end

        def source_folder
          Pathname.new(__scaffolder__.send :source_root).join(source)
        end

        def target_folder
          Pathname.new(__scaffolder__.send :destination_root).join(target)
        end

      end # class Folder

    end # class Base

  end # module CLI

end # module Hexx
