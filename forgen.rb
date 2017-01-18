### ForGen main file
# Ruby Gems
require 'getoptlong'
require 'fileutils'
require 'erb'
require 'nokogiri'
require 'nori'

# Constants libraries
require_relative "lib/constants"

# Class libraries
require "#{DIR_CLASSES}/colour"
require "#{DIR_CLASSES}/outputGenerator"
require "#{DIR_CLASSES}/templateGenerator"
require "#{DIR_CLASSES}/XMLParse"

# Method libraries
require "#{DIR_METHOD_LIBRARIES}/schema.rb"

@colour = Colour.new

def disable_colour
  @colour.disable_colours
end

# Display help message for command line inputs.
def command_help
  @colour.help '--- Welcome to ForGen, the home of custom image creation ---'
  @colour.help 'ForGen command line structure'
  @colour.help 'ruby forgen.rb command [options]'
  @colour.help ''

  @colour.help '[command: main]'
  @colour.help " r, run\t\t\t\t Run all aspects of ForGen"
  @colour.help "-h, --help\t\t\t Display this help screen"
  @colour.help "--list-cases\t\t\t List all case files currently in ForGen"
  @colour.help "--list-modules <type>\t\t List <type> modules that are in ForGen"
  @colour.help ''

  @colour.help '[options: stdout]'
  @colour.help "--disable-colours\t\t Disable all std output colour formatting"
  @colour.help ''

  @colour.help '[options: cases]'
  @colour.help "--case-path\t\t\t The path to the case file to use"
  @colour.help ''

  @colour.help '[options: forensic images]'
  @colour.help "--forensic-image-output-dir\t Output image output directory"
  @colour.help "--create-raw-image\t\t Create a RAW image of all VM drives"
  @colour.help "--create-ewf-image\t\t Create an EWF image of all VM drives"
  @colour.help "--delete-vm-after-image-creation\b\t Delete the VM after image generation"
  @colour.help ''

  @colour.help '[options: modules]'
  @colour.help "--basebox-url\t\t\t URL to the basebox (overwrites basebox modules)"
  @colour.help ''

  @colour.help '[options: vm]'
  @colour.help "--no-vm-shutdown\t\t Stops vm shutdown (will stop forensic image generation)"
  @colour.help "--gui-output\t\t\t Instructs ForGen to create vms in background"
  @colour.help "--max-processor-cap\t\t Sets processor execution cap"
  @colour.help "--max-memory-usage\t\t Sets max vm memory [RAM]"
  @colour.help "--number-of-processors\t\t Sets number of vm processing cores"
  @colour.help ''

  @colour.help '[options: debug]'
  @colour.help "--verbose\t\t\t Run all ForGen elements in verbose mode"
  @colour.help "--debug\t\t\t\t Run all ForGen elements in debug mode"
  @colour.help ''

end

def list_cases
  Dir["#{DIR_CASES}/**/*"].select{ |file| !File.directory? file }.each_with_index do |case_name, case_number|
    @colour.help "#{case_number}) #{case_name}"
  end
end

def list_modules module_type
  if module_type.empty?
    @colour.help "ForGen module types: #{MODULE_TYPES}";
    return;
  end

  if MODULE_TYPES.include? module_type
    @colour.help "Listing modules of type #{module_type}:"
    Dir["#{DIR_MODULES}/#{module_type}/**/forgen_metadata.xml"].select{ |file| !File.directory? file }.each_with_index do |case_name, case_number|
      @colour.help "#{case_number}) #{case_name}"
    end
  else
    @colour.error "Module type [#{module_type}] does not exist"
  end
end

# TODO: Add packer to enable making virtual machines from ISO files, especially in regards to image disk sizes and partitions
#
# TODO Simplify command line options code to make it look nicer, maybe change into a class or use a print class
# TODO Add xml schemer to check the xml is correct :: DONE
# TODO Add vagrant template maker :: DONE
# TODO Parser to parse and replace evidence template file data (either with ForGen parsing facter facts passed to puppet)
# TODO Add lots of modules as well as reusable puppet modules

# case_details_file = "#{DIR_ROOT}/cases/case_details_default.xml"
# case_schema_file = "#{DIR_ROOT}/lib/schema/case.xsd"

options = Hash.new

opts = GetoptLong.new(
    # Help options
    [ '-h', '--help', GetoptLong::NO_ARGUMENT ],

    # Case options
    [ '--case-path', GetoptLong::REQUIRED_ARGUMENT ],
    [ '--list-cases', GetoptLong::NO_ARGUMENT ],

    # Forensic image options
    [ '--forensic-image-output-dir', GetoptLong::NO_ARGUMENT ],
    [ '--create-raw-image', GetoptLong::NO_ARGUMENT ],
    [ '--create-ewf-image', GetoptLong::NO_ARGUMENT ],
    [ '--delete-vm-after-image-creation', GetoptLong::NO_ARGUMENT ],

    # Module options
    [ '--list-modules', GetoptLong::OPTIONAL_ARGUMENT],
    [ '--basebox-url', GetoptLong::REQUIRED_ARGUMENT],

    # Virtual machine options
    [ '--no-vm-shutdown', GetoptLong::NO_ARGUMENT ],
    [ '--max-processor-cap', GetoptLong::REQUIRED_ARGUMENT ],
    [ '--max-memory-usage', GetoptLong::REQUIRED_ARGUMENT ],
    [ '--number-of-processors', GetoptLong::REQUIRED_ARGUMENT ],
    [ '--gui-output', GetoptLong::NO_ARGUMENT ],

    # Debug options
    [ '--verbose', GetoptLong::NO_ARGUMENT ],
    [ '--debug', GetoptLong::NO_ARGUMENT ],

    # Colour options
    [ '--disable-colours', GetoptLong::NO_ARGUMENT ],

)

opts.each do |opt, arg|
  case opt
    # Help options
    when '-h', '--help'
      command_help
      options[:help] = true
      exit

    # Case options
    when '--case-path'
      @colour.help "--case set to #{arg}"
      options[:case_path] = arg

    when '--list-cases'
      @colour.help 'Listing cases:'
      list_cases
      exit

    # Forensic image options
    when '--forensic-image-output-dir'
      @colour.help "--forensic-image-output-dir set to #{arg}"
      options[:forensic_image_output_dir] = arg

    when '--create-raw-image'
      @colour.help '--create-raw-image set to true'
      options[:create_raw_image] = true

    when '--create-ewf-image'
      @colour.help '--create-ewf-image set to true'
      options[:create_ewf_image] = true

    when '--delete-vm-after-image-creation'
      @colour.help '--delete-vm-after-image-creation set to true'
      options[:delete_vm_after_image_creation] = true

    # Module options
    when '--list-modules'
      list_modules arg
      exit

    # Module conditions
    when '--number-of-matching-conditions'
      options[:number_of_matching_conditions] = arg

    # Virtual machine options
    when '--no-vm-shutdown'
      @colour.help '--no-vm-shutdown set to true'
      @colour.help 'Forensic image generation disabled'
      options[:no_vm_shutdown] = true

    when '--max-processor-cap'
      @colour.help "--max-processor-cap set to #{arg}"
      options[:max_processor_cap] = arg

    when '--max-memory-usage'
      @colour.help "--max-memory-usage set to #{arg}"
      options[:max_memory_usage] = arg

    when '--number-of-processors'
      @colour.help "--number-of-processors set to #{arg}"
      options[:number_of_processors] = arg

    when '--gui-output'
      @colour.help '--gui-output set to true'
      options[:gui_output] = true

    when '--basebox-url'
      @colour.help "--basebox-url set to #{arg}"
      options[:basebox_url] = arg

    # Debug options
    when '--verbose'
      @colour.help '--verbose set to true'
      options[:verbose] = true

    when '--debug'
      @colour.help '--debug set to true'
      options[:verbose] = true

    # Colour options
    when '--disable-colours'
      @colour.help '--disable-colouts set to true'
      @colour.disable_colours

    else
      @colour.error "Argument #{opt} not recognised"
  end
end

if ARGV.length < 1
  # command_help
  @colour.error 'Missing main command'
  command_help unless options.has_key? :help
  exit 0
elsif ARGV.length > 1
  # command_help
  @colour.error 'Too many main commands'
  command_help unless options.has_key? :help
  exit 0
end

case ARGV[0]
  # TODO: Schema files, Evidence/forensic/forensic
  # TODO: Module selection
  # TODO: Validation of modules and dependencies
  # TODO: Vagrantfile.template erb and configuration
  # TODO: Puppetfile erb and configuration
  # TODO: Facter configuration
  #
  #
  #   TODO: 1) Validate schema :: DONE
  #   TODO: 2) Get case data from xml file :: DONE
  #   TODO: 3) Build vagrant, puppet and human readable files :: DONE
  #
  #
  # TODO MAIN: Boot up basebox with vagrant --> Add module to basebox via Puppetfile.template
  # TODO SECONDARY: Add schema files --> Add module selection
  #
  # -----------------------------------------------------------------------------------------
  #
  # TODO: Add build modules for windows and an exclude windows build modules for linux
  #
  # TODO: If XML module input is given as a path look in path and ignore rest of module selection filters
  #

  when 'r','run'
    @colour.notify "Run command"

    ### Create Vagrant Basebox via Packer
    

    ### Declare options hash variables
    # Set vagrant box name to default if not set
    options[:vagrant_box_name] = 'Forgen_default_machine' # unless options.has_key? :vagrant_box_name

    options[:number_of_matching_conditions] = 3 unless options.has_key? :number_of_matching_conditions

    ### Parse xml
    options[:case_path] = "#{DIR_CASES}/case_details_default.xml" unless options.has_key? :case_path

    @colour.notify "Validating case file '#{options[:case_path]}'"
    # Validate case file
    case_xml, errors = validate_schema(options[:case_path], "#{DIR_SCHEMA}/case.xsd")

    # Create nori parser xml to ruby hash template and give it to the XMLParser object
    nori_parser = Nori.new(:convert_tags_to => lambda { |tag| tag.snakecase.to_sym })
    xml_parse = XMLParse.new(nori_parser)

    # Convert xml case file to ruby hash
    case_hash = xml_parse.xml_file_to_hash(options[:case_path])

    # Create array of desired modules from ruby hash
    desired_modules = Array.new
    case_hash[:case].each_value do |system|
      desired_modules << system[:modules][:module]
    end

    # Get all forgen_metadata.xml paths
    forgen_metadata_paths = Dir["#{DIR_MODULES}/**/**/**/*"].select{ |file| File.file?(file) && file.include?('forgen_metadata.xml') }

    # Parse all forgen_metadata.xml files
    module_hash = Array.new
    forgen_metadata_paths.each do |file_path|
      module_hash << xml_parse.xml_file_to_hash(file_path)
    end

    # Compare and validate forgen files and desired module selections
    selected_modules = Hash.new
    module_hash.each do |module_type|
      module_type.each do |type, details|
        @colour.notify "Validating module '#{details[:path]}' against schema '#{type}.xsd'"
        validate_schema("#{DIR_MODULES}/#{details[:path]}/forgen_metadata.xml", "#{DIR_SCHEMA}/#{type}.xsd")

        @colour.notify "Checking if module '#{details[:path]}' matches configuration in #{options[:case_path]}"
        desired_modules.each do |desired_module_type|
          desired_module_type.each do |desired_module_details|
            if (desired_module_details.select{|k,v| details[k.to_sym] == v }.size >= options[:number_of_matching_conditions])
              @colour.notify "Module #{details[:path]} matches at least #{options[:number_of_matching_conditions]} desired conditions"

              selected_modules["#{details[:type]}_#{details[:category]}_#{details[:name]}"] = details
            end
          end
        end

      end
    end

    ### Make config
    options[:project_dir] = "#{DIR_PROJECTS}/ForGen_Project_#{Time.now.strftime("%Y-%m-%d_%H:%M:%S")}"
    options[:vm_name] = options[:project_dir].split("/").last #unless options.has_key? [:vm_name] # <-- Could have multiple vms

    # Make project directory
    @colour.notify "Creating new project directory '#{options[:project_dir]}'"
    Dir.mkdir(options[:project_dir])

    # Create modules hash
    @colour.notify "Selecting puppet configuration modules for project #{options[:project_dir]}"
    config_modules = Hash.new

    selected_modules.each do |module_name, module_info|
      config_modules["#{module_info[:provider]}".to_sym] = { module_name => module_info } if (PUPPET_MODULE_TYPES.include?(module_info[:type]))
    end

    ## Generate Template files
    templateGenerator = TemplateGenerator.new(options, config_modules)

    # Generate Vagrantfile
    @colour.notify 'Creating Vagrantfile'
    templateGenerator.create_template_file("#{DIR_TEMPLATE}/Vagrantfile.erb","#{options[:project_dir]}/Vagrantfile")

    # Generate Puppetfile
    @colour.notify 'Creating Puppetfile'
    templateGenerator.create_template_file("#{DIR_TEMPLATE}/Puppetfile.erb","#{options[:project_dir]}/Puppetfile")

    outputGenerator = OutputGenerator.new(options, case_xml)

    # Generate XML output file
    @colour.notify 'Generating XML output file'
    outputGenerator.create_xml_output_file("#{options[:project_dir]}/CaseDetails.xml")

    ## Create puppet module structure withing project directory using librarian-puppet
    @colour.notify "Creating Puppet module struction using librarian-puppet for project #{options[:project_dir]}"
    system "cd #{options[:project_dir]} && librarian-puppet install"

    ### Make Virtualbox image
    @colour.notify "Ensuring following commands run from directory '#{options[:project_dir]}/Vagrantfile'"
    @colour.notify 'Executing vagrant up (this may take a while)'

    if options.has_key? :debug
      system "cd #{options[:project_dir]} && vagrant up --debug"
    else
      system "cd #{options[:project_dir]} && vagrant up"
    end

    ### Make forensic image
    drive_path = %x(VBoxManage list hdds | grep '#{options[:project_dir].split('/').last}').sub(/\ALocation:\s*/, '').sub(/\n/, '')
    # drive_path = %x(VBoxManage list hdds | grep '#{options[:project_dir].split('/').last}').sub(/\ALocation:\s*|\n\Z/, '')
    drive_name = drive_path.split('/').last

    options[:image_output_location] = "#{options[:project_dir]}/#{drive_name}".sub(/.vmdk|.vdi/, '') unless options.has_key? :image_output_location

    unless options.has_key? :no_vm_shutdown
      ## Ensure all vms are shutdown
      system "cd #{options[:project_dir]} && vagrant halt"

      if options.has_key? :create_raw_image
        ## Make DD image
        @colour.notify "Creating dd image with path #{options[:image_output_location]}.raw"
        @colour.notify 'This may take a while:'
        @colour.notify "Raw image #{options[:image_output_location]}.raw created" if system "VBoxManage clonemedium disk '#{drive_path}' '#{options[:image_output_location]}.raw' --format RAW"
      end

      if options.has_key? :create_ewf_image
        ## Make E01 image
        @colour.notify "Creating E01 image with path #{options[:image_output_location]}.E01"
        @colour.notify 'This may take a while:'
        @colour.notify "E01 image #{options[:image_output_location]}.E01 created" if system "ftkimager '#{drive_path}' '#{options[:image_output_location]}' --e01"
      end

      if options.has_key? :delete_vm_after_image_creation
        @colour.notify "Deleting VirtualBox VM #{options[:vm_name]}"
        @colour.notify "VirtualBox VM #{options[:vm_name]} deleted" if system "VBoxManage unregistervm #{options[:vm_name]} --delete"
      end
    end

    @colour.notify 'Run command finished'

  # options = make_config(options)
    # options = make_virtualbox_image(options)
    # options = make_forensics_image(options)
    # options = make_test_sheets(options)
    # options = make_mark_sheets(options)

end