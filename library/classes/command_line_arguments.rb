### Command line options method library file
## Four options
# Help (-h, --help)
# {displays help data and these commands}
# [no parameters accepted]
#
# Make Image template (-mt, --make-template)
# {make all vagrant and puppet file templates
# to be used in project and stored in project
# directory (with correct number, e.g. project1)}
# [no parameters accepted]
#
# Make Image file from saved template (-mi, --make-image)
# {make image file from all template files for an existing project}
# [1 parameter accepted - (existing_project_number/existing_project_name)]
#
# Make both template files and image file (-m, --make-all)
# {make both the project template files and the
# final image file based on the created project}
# [no parameters accepted]

require_relative "#{DIR_CLASSES}/colour"


class Command_line_arguments
  def initialize
    @colour = Colour.new
  end

  def disable_colour
    @colour.disable_colours
  end

  # def run_arguments(p)
  #   if (p.length == 0)
  #     command_help
  #     puts
  #     exit(0)
  #   end
  #
  #   # p.each do |p_arg|
  #   p.length.times do |p_arg|
  #     # case p_arg
  #     case p[0]
  #       when '-h', '--help'
  #         command_help
  #         p.shift
  #
  #       when '-m', '--more'
  #         puts
  #         # puts '-- More specific help --'
  #         @colour.puts_title '-- More specific help --'
  #         if ((p.length-1) > 0)
  #           puts
  #           display_help_more(p)
  #         else
  #           puts "Argument -m must take at least one parameter"
  #         end
  #         puts
  #         exit(0)
  #
  #       when '-mt', '--more'
  #
  #
  #       when '--disable-colours'
  #         @colour.disable_colours
  #         p.shift
  #
  #       else
  #         # command_help
  #         puts "Argument #{p[0]} not recognised"
  #         p.shift
  #     end
  #   end
  # end

  # Display help message for command line inputs.
  def command_help
    @colour.output('puts', 'bold_help', '--- Welcome to ForGen, the home of custom image creation ---')
    @colour.output('puts', 'text_help', 'ForGen command line structure')
    @colour.output('puts', 'text_help', 'ruby ForGen.rb [options]')
    @colour.output('puts', 'text_help', '')
    @colour.output('puts', 'bold_help', '[options]')
    @colour.output('puts', 'text_help', "-h  --help\t\t\t Display this help screen")
    @colour.output('puts', 'text_help', "-m  --more [argument]\t\t Find more about the other options")
    @colour.output('puts', 'text_help', "-mt --make-template\t\t Make all required Image template files")
    @colour.output('puts', 'text_help', "-mi --make-image [project num]\t Make Image file from saved template")
    # @colour.output('puts', 'text_help', "-mvi --make-virtualbox-image [project num]\t Make virtualbox image from saved template")
    # @colour.output('puts', 'text_help', "-mfi --make-virtualbox-image [project num]\t Make forensic image from saved template")
    @colour.output('puts', 'text_help', "-ma --make-all\t\t\t Make both template files and image file")
  end

  # Display help message for a specific command line input.
  def display_help_more (arguments)
    arguments.shift
    arguments.each do |argument|
      case argument
        when '-h', '--help'
          @colour.output('puts', 'bold_help', '-h --help')
          @colour.output('puts', 'text_help', "\t  Displays help screen with all common commands
          and a short description")

        when '-m', '--more'
          @colour.output('puts', 'bold_help', '-m --more')
          @colour.output('puts', 'text_help', "\t  Displays a more elaborate help section for each
          command after the -m or --more command")

        when '-mt', '--make-template'
          @colour.output('puts', 'bold_help', '-mt --make-template')
          @colour.output('puts', 'text_help', "\t  Make Image template
          {make all vagrant and puppet file templates
          to be used in project and stored in project
          directory (with correct number, e.g. project1)}
          [no parameters accepted]")

        when '-mi', '--make-image'
          @colour.output('puts', 'bold_help', '-mi --make-image')
          @colour.output('puts', 'text_help', "\t  Make Image file from saved template
          {make image file from all template files for an existing project}
          [1 parameter accepted - (existing_project_number/existing_project_name)]")

        when '-ma', '--make-all'
          @colour.output('puts', 'bold_help', '-ma --make-all')
          @colour.output('puts', 'text_help', "\t  Make both template files and image file
          {make both the project template files and the
          final image file based on the created project}
          [no parameters accepted]")

        when '-mt', '--more'
          #   TODO: 1) Validate schema
          #   TODO: 2) Get case data from xml file
          #   TODO: 3) Build vagrant, puppet and human readable files
          @colour.output('puts', 'bold_help', '-mt --make-template')
          @colour.output('puts', 'text_help', "\t  Make template files that can generate images
          {make the project template files based on the default or specified case files}
          [no parameters accepted]")

        when '-mvi', '--make-virtualbox-image'
          # TODO: Fill in more help for -mvi (--make-virtualbox-image)
          @colour.output('puts', 'bold_help', '-mvi --make-virtualbox-image')
          @colour.output('puts', 'text_help', "\t  TODO
          {TODO}
          [no parameters accepted]")
        when '-mfi', '--make-forensic-image'
          # TODO: Fill in more help for -mfi (--make-forensic-image)
          @colour.output('puts', 'bold_help', '-mvi --make-virtualbox-image')
          @colour.output('puts', 'text_help', "\t  TODO
          {TODO}
          [no parameters accepted]")
        when '--validate-case-file'
          # TODO: Fill in more help for --validate-case-file
          @colour.output('puts', 'bold_help', '-mvi --make-virtualbox-image')
          @colour.output('puts', 'text_help', "\t  TODO
          {TODO}
          [no parameters accepted]")
        when '--list-all-commands'
          # TODO: Fill in more help for --list-all-commands
          @colour.output('puts', 'bold_help', '--list-all-commands')
          @colour.output('puts', 'text_help', "\t  TODO
          {TODO}
          [no parameters accepted]")
        else
          # puts "Argument #{argument} not recognised"
          @colour.output('puts', 'text_error', "#{argument} \n\t  Argument #{argument} not recognised")
        # display_help
      end
    end
  end
end