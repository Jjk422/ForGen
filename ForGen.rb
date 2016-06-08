### ForGen main file
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

# Display help message for command line inputs.
def display_help
  puts '--- Welcome to ForGen, the home of custom image creation ---'
  puts 'ForGen command line structure'
  puts 'ruby ForGen.rb [options]'
  puts
  puts '[options]'
  puts "-h  --help\t\t\t Display this help screen"
  puts "-m  --more [argument]\t\t Find more about the other options"
  puts "-mt --make-template\t\t Make all required Image template files"
  puts "-mi --make-image [project num]\t Make Image file from saved template"
  puts "-ma --make-all\t\t\t Make both template files and image file"

end

# Display help message for a specific command line input.
def display_help_more (argument)
  case argument
    when '-h', '--help'
      puts '-h --help
Displays help screen with all common commands
and a short description'
    when '-m', '--more'
      puts '-m --more
Displays a more elaborate help section for each
command after the -m or --more command'
    when '-mt', '--make-template'
      puts '-mt --make-template
  Make Image template
  {make all vagrant and puppet file templates
  to be used in project and stored in project
  directory (with correct number, e.g. project1)}
  [no parameters accepted]'

    when '-mi', '--make-image'
      puts '-mi --make-image
  Make Image file from saved template
  {make image file from all template files for an existing project}
  [1 parameter accepted - (existing_project_number/existing_project_name)]'

    when '-ma', '--make-all'
      puts '-ma --make-all Make both template files and image file
  {make both the project template files and the
  final image file based on the created project}
  [no parameters accepted]'

    else
      puts "Argument #{argument} not recognised"
    # display_help
  end
end

# def check_arguments (arguments)
#   case arguments[0]
#     when '-h' || '--help'
#       display_help
#     when '-m' || '--more'
#       display_help_more(arguments[arguments.index(arguments).to_i + 1])
#     when '-mt' || '--make-template'
#       puts '-mt'
#     when '-mi' || '--make-image'
#       puts '-mi'
#     when '-ma' || '--make-all'
#       puts '-ma'
#     else
#       display_help
#   end
# end


require_relative 'library/CONSTANTS'
require_relative 'library/classes/xml_reader.rb'
require_relative 'library/file_mover'

arguments = []
ARGV.each do|a|
  arguments << a
end

# check_arguments arguments

case arguments[0]
  when '-h', '--help'
    display_help
  when '-m', '--more'
    # display_help_more(arguments[arguments.index(arguments).to_i + 1])

    arguments.shift
    if arguments.length == 0
      display_help
    else
      arguments.each do |argument|
        display_help_more(argument)
      end
    end
  when '-mt', '--make-template'
    puts '-mt'
  when '-mi', '--make-image'
    puts '-mi'
  when '-ma', '--make-all'
    puts '-ma'
  else
    display_help
end

xml_reader = Xml_Reader.new

puts
case_details = xml_reader.read_file('case_details.xml')

case_details.each do |detail|
  puts detail
end



create_mount