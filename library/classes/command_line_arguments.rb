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


end