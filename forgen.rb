### ForGen main file
# Ruby Gems
require 'getoptlong'
require 'file'

# Constants libraries
require_relative "library/CONSTANTS"

# Class libraries
# require_relative "#{DIR_ROOT}/library/classes/xml_reader.rb"

# Method libraries
require_relative "#{DIR_METHOD_LIBRARIES}/command_line"
require_relative "#{DIR_METHOD_LIBRARIES}/xml"
require_relative "#{DIR_CLASSES}/command_line_arguments"
require_relative "#{DIR_CLASSES}/colour"

@colour = Colour.new

def disable_colour
  @colour.disable_colours
end

# Display help message for command line inputs.
def command_help
  @colour.help '--- Welcome to ForGen, the home of custom image creation ---'
  @colour.help 'ForGen command line structure'
  @colour.help 'ruby forgen.rb [options]'
  @colour.help ''
  @colour.help '[options]'
  @colour.help "-h  --help\t\t\t Display this help screen"
  @colour.help "-m  --more [argument]\t\t Find more about the other options"
  @colour.help "-mt --make-template\t\t Make all required Image template files"
  @colour.help "-mi --make-image [project num]\t Make Image file from saved template"
  # @colour.output('puts', 'text_help', "-mvi --make-virtualbox-image [project num]\t Make virtualbox image from saved template")
  # @colour.output('puts', 'text_help', "-mfi --make-virtualbox-image [project num]\t Make forensic image from saved template")
  @colour.help "-ma --make-all\t\t\t Make both template files and image file"
end

# Display help message for a specific command line input.
def display_help_more (argument)
  case argument
    when '--list-commands'
      # TODO: Fill in more help for --list-commands
      @colour.help '--list-commands'
      @colour.help "\t  TODO
          {TODO}
          [no parameters accepted]"

    when 'r','run'
        @colour.help 'r run'
        @colour.help "\t  Make both template files and image file
          {make both the project template files and the
          final image file based on the created project}
          [no parameters accepted]"

    when 'mc', 'make-config'
      @colour.help 'mc make-config'
      @colour.help "\t  Make Image configuration files
          {make all vagrant and puppet file templates
          to be used in project and stored in project
          directory (with correct number, e.g. project1)}
          [no parameters accepted]"
      @colour.help "\t  Make template files that can generate images
          {make the project template files based on the default or specified case files}
          [no parameters accepted]"

    when 'mvi', 'make-virtualbox-image'
      @colour.help 'mi make-virtualbox-image'
      @colour.help "\t  Make Image file from saved template
          {make image file from all template files for an existing project}
          [1 parameter accepted - (existing_project_number/existing_project_name)]"
    when 'mfi', 'make-forensic-image'
      # TODO: Fill in more help for -mfi (--make-forensic-image)
      @colour.help 'mvi make-virtualbox-image'
      @colour.help "\t  TODO
          {TODO}
          [no parameters accepted]"
    when 'mts', 'make-test-sheet'
      @colour.help "Make test sheet"

    when 'mms', 'make-mark-sheet'
      @colour.help "Make mark sheet"

    when 'mts', 'make-test-sheet'
      @colour.help "Make test sheet"

    when 'mms', 'make-mark-sheet'
      @colour.help "Make mark sheet"

  ## Extra commands (program execution stopped)

  ## Extra commands (program execution continues)
    when '-h'
      @colour.help '-h --help'
      @colour.help "\t  Displays help screen with all common commands
          and a short description"

    when '-m'
      @colour.help '-m --more'
      @colour.help "\t  Displays a more elaborate help section for each
          command after the -m or --more command"

    when '--disable-colours'

    when '--validate-case-file'
          # TODO: Fill in more help for --validate-case-file
          @colour.help '-mvi --make-virtualbox-image'
          @colour.help "\t  TODO
          {TODO}
          [no parameters accepted]"
    when '--create-image-in-background'

    when '--max-processor-cap'

    when '--max-memory-usage'

    when '--number-of-processors'


#############################################################

    else
      # puts "Argument #{argument} not recognised"
      @colour.output('puts', 'text_error', "#{argument} \n\t  Argument #{argument} not recognised")
    # display_help
  end
end

# TODO Simplify command line options code to make it look nicer, maybe change into a class or use a print class
# TODO Add xml schemer to check the xml is correct
# TODO Add vagrant template maker
# TODO Parser to parse and replace evidence template file data (either with ForGen parsing facter facts passed to puppet)
# TODO Add lots of modules as well as reusable puppet modules

case_details_file = "#{DIR_ROOT}/scenarios/case_details_default.xml"
case_schema_file = "#{DIR_ROOT}/library/schema/case.xsd"

opts = Hash.new

opts = GetoptLong.new(
    [ '-h', '--help', GetoptLong::OPTIONAL_ARGUMENT ],
    [ '-m', '--more', GetoptLong::REQUIRED_ARGUMENT ],
    [ '--validate-case-file', GetoptLong::OPTIONAL_ARGUMENT],
    [ '--create-image-in-background', GetoptLong::OPTIONAL_ARGUMENT ],
    [ '--disable-colours', GetoptLong::OPTIONAL_ARGUMENT ],
    [ '--list-commands', GetoptLong::OPTIONAL_ARGUMENT ],
)

opts.each do |opt, arg|
  case opt
    when '-h', '--help'
      command_help

    when '-m', '--more'
      puts ''
      # puts '-- More specific help --'
      @colour.bold_help '-- More specific help --'
      display_help_more(arg)

    # Virtual machine options
    when '--max-processor-cap'
      @colour.help "--max-processor-cap set to #{opt}"
      opts['max-processor-cap'] = opt

    when '--max-memory-usage'
      @colour.help "--max-memory-usage set to #{opt}"
      opts['max-memory-usage'] = opt

    when '--number-of-processors'
      @colour.help "--number-of-processors"
      opts['number-of-processors'] = opt

    # Other options
    when '--validate-case-file'

    when '--create-image-in-background'

    when '--disable-colours'
      @colour.disable_colours

    # TODO: Keep --list-commands up to date
    when '--list-commands'
      @colour.help_title '-- Listing commands --'
      ## Main commands
      display_help_more '--list-commands'

      display_help_more 'r'
      display_help_more 'mc'
      display_help_more 'mvi'
      display_help_more 'mfi'
      display_help_more 'mts'
      display_help_more 'mms'

      ## Extra commands (program execution stopped)

      ## Extra commands (program execution continues)
      display_help_more '-h'
      display_help_more '-m'

      display_help_more '--disable-colours'
      display_help_more '--validate-case-file'
      display_help_more '--create-image-in-background'
      display_help_more '--max-processor-cap'
      display_help_more '--max-memory-usage'
      display_help_more '--number-of-processors'

    else
      # command_help
      @colour.output('puts','text_error',"Argument #{arg} not recognised")
      # @colour.output('puts','text_error',"Use -h for help")
      command_help
  end
end

def make_config(opts)
  @colour.notify "Making ForGen configuration files"
  if file
end

def make_virtualbox_image(opts)

end

def make_forensics_image(opts)

end

def make_test_sheets(opts)

end

def make_mark_sheets(opts)

end

if ARGV.length < 1
  @colour.help 'Missing main command'
  exit 0
elsif ARGV.length > 1
  @colour.help 'Too many main commands'
  exit 0
end

case ARGV[0]
  # TODO: Schema files, Evidence/forensic/system
  # TODO: Module selection
  # TODO:
  #
  #
  #
  #
  #
  #   TODO: 1) Validate schema
  #   TODO: 2) Get case data from xml file
  #   TODO: 3) Build vagrant, puppet and human readable files
  #
  #
  # TODO MAIN: Boot up basebox with vagrant --> Add module to basebox via PuppetFile
  # TODO SECONDARY: Add schema files --> Add module selection
  #

  when '-r','--run'
    @colour.notify "Run command"

    opts = make_config(opts)
    opts = make_virtualbox_image(opts)
    opts = make_forensics_image(opts)
    opts = make_test_sheets(opts)
    opts = make_mark_sheets(opts)

  when 'mc', 'make-config'
    @colour.notify "Make config command"
  when 'mvi', 'make-virtualbox-image'
    @colour.notify "Make virtualbox image"
  when 'mfi', 'make-forensic-image'
    @colour.notify "Make forensic image"
  when 'mts', 'make-test-sheet'
    @colour.notify "Make test sheet"
  when 'mms', 'make-mark-sheet'
    @colour.notify "Make mark sheet"
end