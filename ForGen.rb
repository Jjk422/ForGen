### ForGen main file

# Constants libraries
require_relative "library/CONSTANTS"

# Class libraries
# require_relative "#{DIR_ROOT}/library/classes/xml_reader.rb"

# Method libraries
# require_relative "#{DIR_ROOT}/library/method_libraries/file_mover"
require_relative "#{DIR_METHOD_LIBRARIES}/command_line"
require_relative "#{DIR_METHOD_LIBRARIES}/xml"
require_relative "#{DIR_CLASSES}/command_line_arguments"
require_relative "#{DIR_CLASSES}/colour"

# TODO Simplify command line options code to make it look nicer, maybe change into a class or use a print class
# TODO Add xml schemer to check the xml is correct
# TODO Add vagrant template maker
# TODO Parser to parse and replace evidence template file data (either with ForGen parsing facter facts passed to puppet)
# TODO Add lots of modules as well as reusable puppet modules
# TODO Build in disable colour function

case_details_file = "#{DIR_ROOT}/scenarios/case_details_default.xml"
case_schema_file = "#{DIR_ROOT}/library/schema/case.xsd"

# validate_schema(case_details_file, case_schema_file)        ##### <<<<< #####
# case_details = parse_xml(case_details_file)                 ##### <<<<< #####
# puts case_details

# case_details.xpath.each { |element| puts "Element: #{element}" }
# # puts case_details.css('people')
#
# get_all_values(case_details)


command_line_arguments = Command_line_arguments.new
colour = Colour.new

# command_line_arguments.run_arguments(ARGV)

# puts "\n"

args = ARGV

if (args.length == 0)
  command_line_arguments.command_help
  puts
  exit(0)
end

# p.each do |p_arg|
args.length.times do
  # case p_arg
  case args[0]
    when '-h', '--help'
      command_line_arguments.command_help
      args.shift

    when '-m', '--more'
      puts ''
      # puts '-- More specific help --'
      colour.output('puts', 'title', '-- More specific help --')
      if ((args.length-1) > 0)
        puts
        command_line_arguments.display_help_more(args)
      else
        colour.output('puts', 'text_error', "Argument -m must take at least one parameter")
      end
      puts
      exit(0)

    when '-mt', '--more'
      #   TODO: 1) Validate schema
      #   TODO: 2) Get case data from xml file
      #   TODO: 3) Build vagrant, puppet and human readable files
      validate_schema(case_details_file, case_schema_file)        ##### <<<<< #####
      # case_details = parse_xml(case_details_file)                 ##### <<<<< #####
      # puts case_details

      # case_details.xpath.each { |element| puts "Element: #{element}" }
      # puts case_details.css('people')

      # get_all_values(case_details)

      Dir.mkdir("#{DIR_ROOT}/projects") unless File.directory? "#{DIR_ROOT}/projects"

      temp_dir_store = []
      Dir.entries("#{DIR_ROOT}/projects").select do |project_directory|
        temp_dir_store << project_directory
      end

      colour.output('puts','text_notify','Calculating free directory names')
      i = 0
      project_name = 'project_1'
      loop do
        i = i + 1
        project_name_temp = ["project_#{i}"]
        if (temp_dir_store & project_name_temp).empty?
          project_name = "project_#{i}"
          break
        end
      end

      colour.output('puts','text_notify',"Making new project directory [#{project_name}]")
      Dir.mkdir("#{DIR_ROOT}/projects/#{project_name}")

      case_details_file_name = case_details_file.split('/')[-1]
      puts case_details_file_name

      # File.new("#{DIR_ROOT}/projects/#{project_name}/#{case_details_file_name}",'r')

      xml = File.read(case_details_file)
      doc = Nokogiri::XML(xml)
      # ... make changes to doc ...
      File.write("#{DIR_ROOT}/projects/#{project_name}/#{case_details_file_name}", doc.to_xml)

    when '-mi', '--make-image'
      # Add code or delete if not necessary, also remove, change or add in -m options
      colour.output('puts', 'text_error','TO BE COMPLETED')

    when '-ma', '--make-all'
      # Add code or delete if not necessary, also remove, change or add in -m options
      colour.output('puts', 'text_error','TO BE COMPLETED')

    when '-mvi', '--make-virtualbox-image'
      # Add code or delete if not necessary, also remove, change or add in -m options
      colour.output('puts', 'text_error','TO BE COMPLETED')

    when '-mfi', '--make-forensic-image'
      # Add code or delete if not necessary, also remove, change or add in -m options
      colour.output('puts', 'text_error','TO BE COMPLETED')

      # Other options
    when '--validate-case-file'
      # case_details_file = (args[1].nil?)?"#{DIR_ROOT}/scenarios/case_details_default.xml":args[1];
      # case_schema_file = (args[2].nil?)?"#{DIR_ROOT}/library/schema/case.xsd":args[2];

      # case_details_file = args[1]
      # case_schema_file = args[2]

      # colour.puts_text_error "#{DIR_ROOT}/scenarios/case_details_default.xml"
      # colour.puts_text_error "#{DIR_ROOT}/library/schema/case.xsd"

      # TODO: Check files are actually present so can be used and do not cause errors with extra arguments placed after
      if (!args[1].nil? and !args[2].nil? and (File.file?(args[1]) and File.file?(args[2])))
        case_details_file = args[1]
        case_schema_file = args[2]
        args.shift
        args.shift
        args.shift
      else
        colour.output('puts', 'text_error', '2 arguments are required for schema validation, the case file and the schema file')
        colour.output('puts', 'text_help', 'Use the options -m --validate-case-file for more details')
        args.shift
        args.shift
        args.shift
        next
      end

      # args.drop(3)
      # args.shift
      # args.shift
      # args.shift

      colour.output('print', 'text_notify', "Validating xml file ")
      colour.output('print', 'bold_notify', case_details_file)
      colour.output('print', 'text_notify', " against xsd schema file ")
      colour.output('puts', 'bold_notify', case_schema_file)

      validate_schema(case_details_file, case_schema_file)

      colour.output('puts', 'text_urgent', 'Both files validated correctly')

    when '--create-image-in-background'
      # Add code or delete if not necessary, also remove, change or add in -m options
      colour.output('puts', 'text_error','TO BE COMPLETED')

    when '--disable-colours'
      colour.disable_colours
      command_line_arguments.disable_colour
      args.shift

    # TODO: Keep --list-all-commands up to date
    when '--list-all-commands'
      colour.output('puts','title','-- List all commands --')
      command_line_arguments.display_help_more(['-h','-m','-mt','-mi','-ma','-mt','-mvi','-mfi','--validate-case-file','--list-all-commands'])
      args.shift

    else
      # command_help
      colour.output('puts','text_error',"Argument #{args[0]} not recognised")
      # colour.output('puts','text_error',"Use -h for help")
      command_line_arguments.command_help
      args.shift
  end
  exit(0) if (args.length == 0)
end

puts "\n"


























# # puts ARGV.length
#
# # puts 'Test [' + print.red('test') + ']'
# # puts 'Test [' + print.green('test') + ']'
#
# # puts
# # 1..100.times do | i |
# #   print print.colorize('Tes:' + i.to_s,i)
# #   print "\t"
# # end
# # puts
#
# # $ARGV.each do |argument|
#   command_line_arguments.run_arguments(ARGV)
#
#   puts "\n"
# # end


# arguments = []
# ARGV.each do|a|
#   arguments << a
# end
#
# # check_arguments arguments
#
# case arguments[0]
#   when '-h', '--help'
#     display_help
#   when '-m', '--more'
#     # display_help_more(arguments[arguments.index(arguments).to_i + 1])
#
#     arguments.shift
#     if arguments.length == 0
#       display_help
#     else
#       arguments.each do |argument|
#         display_help_more(argument)
#       end
#     end
#   when '-mt', '--make-template'
#     puts '-mt'
#   when '-mi', '--make-image'
#     puts '-mi'
#   when '-ma', '--make-all'
#     puts '-ma'
#   else
#     display_help
# end
#
# xml_reader = Xml_Reader.new
#
# puts
# case_details = xml_reader.read_file('scenarios/case_details_default.xml')
#
# case_details.each do |detail|
#   puts detail
# end
#
#
#
#
#
# # create_mount