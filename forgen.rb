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
require "#{DIR_CLASSES}/module_selector"
require "#{DIR_CLASSES}/data_store"
require "#{DIR_CLASSES}/output_generator"
require "#{DIR_CLASSES}/template_generator"
require "#{DIR_CLASSES}/xml_parse"

# Method libraries
require "#{DIR_METHOD_LIBRARIES}/schema.rb"

#################################################
#################################################

# Disable all command line colours
#
# @author Jason Keighley
# @see Colour#disable_colours
# @return [Void]
def disable_colour
  @colour.disable_colours
end

#################################################
#################################################

# Display a help message for command line inputs
#
# @author Jason Keighley
# @return [Void]
def command_help
  @colour.help '--- Welcome to ForGen, the home of custom image creation ---'
  @colour.help 'ForGen command line structure'
  @colour.help 'ruby forgen.rb command [options]'
  @colour.help ''

  @colour.help '[command: main]'
  @colour.help "r, run\t\t\t\t Run all aspects of ForGen"
  @colour.help "make-configuration\t\t Make configuration files for a new project"
  @colour.help "make-vagrant-basebox\t\t Make a vagrant basebox"
  @colour.help "make-virtual-machine\t\t Make a virtual machine"
  @colour.help "make-forensic-image\t\t Make a forensic image"
  @colour.help ''

  @colour.help '[command: information]'
  @colour.help "-h, --help\t\t\t Display this help screen"
  @colour.help "--version\t\t\t Displays the current ForGen version"
  @colour.help "--list-cases\t\t\t List all case files currently in ForGen"
  @colour.help "--list-modules <type>\t\t List <type> modules that are in ForGen"
  @colour.help ''

  @colour.help '[command: projects]'
  @colour.help "--delete-all-projects\t\t Deletes ALL projects in the projects directory"
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

#################################################
#################################################

# Displays the current ForGen version number
#
# @author Jason Keighley
# @see constants.rb
# @return [Void]
def display_version
  @colour.help FORGEN_VERSION_NUMBER
end

#################################################
#################################################

# Displays all current ForGen cases
#
# @author Jason Keighley
# @see constants.rb
# @return [Void]
def list_cases
  Dir["#{DIR_CASES}/**/*"].select{ |file| !File.directory? file }.each_with_index do |case_name, case_number|
    @colour.help "#{case_number}) #{case_name}"
  end
end

#################################################
#################################################

# Lists modules of given \module type
#
# @author Jason Keighley
# @param [String] module_type The type of \module to be listed
# @return [Void]
def list_modules module_type
  if module_type.empty?
    @colour.help "ForGen module types: #{MODULE_TYPES}"
    return
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

#################################################
#################################################

# Delete all current project directories
#
# @author Jason Keighley
# @return [Void]
def delete_all_projects
  FileUtils.rm_rf(Dir.glob("#{DIR_PROJECTS}/*"))
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

#################################################
#################################################

# Make all configuration files
#
# @author Jason Keighley
# @param [Hash] options Main options hash containing all options for the running ForGen instance
# @return [Hash] options Main options hash containing all options for the running ForGen instance
def make_configuration(options)
  options[:number_of_matching_conditions] = 3 unless options.has_key? :number_of_matching_conditions

  ### Parse xml
  options[:case_path] = "#{DIR_CASES}/case_details_default.xml" unless options.has_key? :case_path

  @colour.notify "Validating case file '#{options[:case_path]}'"
  # Validate case file
  case_xml, errors = validate_schema(options[:case_path], "#{DIR_SCHEMA}/case.xsd")

  # (@colour.error errors; exit 0;) if errors.length > 0

  # Create nori parser xml to ruby hash template and give it to the XMLParser object
  nori_parser = Nori.new(:convert_tags_to => lambda { |tag| tag.snakecase.to_sym })
  xml_parse = XMLParse.new(nori_parser)

  # Convert xml case file to ruby hash
  case_hash = xml_parse.xml_file_to_hash(options[:case_path])

  # Parse datastore information from dataStore and save to options[:data_store]
  dataStore = DataStore.new(@colour ,case_hash)

  dataStore.parse_case_hash

  options[:data_store] = dataStore.get_datastore

  ### Select Configuration modules
  # TODO: Make module selector create array hash structure for single modules in xml file ({:provisioner}=>[{"Module_name"}=>{Mod_info_1=>Mod_val_1, Mod_info_2=>Mod_val_2, Mod_info_3=>Mod_val_3}])
  moduleSelector = ModuleSelector.new(@colour, options, xml_parse, case_hash)
  options[:base_module], config_modules = moduleSelector.select_modules

  options[:project_dir] = "#{DIR_PROJECTS}/ForGen_Project_#{Time.now.strftime("%Y-%m-%d_%H-%M-%S")}" unless options[:project_dir]
  options[:basebox_url] = "#{options[:project_dir]}/#{options[:base_module][:name]}_#{options[:virtualisation_provider]}.box" unless options.has_key? :basebox_url
  options[:basebox_name] = options[:basebox_url].split('/').last
  options[:vm_name] = options[:project_dir].split("/").last #unless options.has_key? [:vm_name] # <-- Could have multiple vms

  Dir.mkdir("#{DIR_ROOT}/projects") unless File.directory? "#{DIR_ROOT}/projects"

  # Make project directory
  @colour.notify "Creating new project directory '#{options[:project_dir]}'"
  Dir.mkdir(options[:project_dir])

  ## Generate Template files
  templateGenerator = TemplateGenerator.new(options, config_modules)

  ### Packer
  # Create Packerfile
  @colour.notify 'Creating Packerfile'
  templateGenerator.create_template_file("#{DIR_TEMPLATE}/Packerfile.erb","#{options[:project_dir]}/Packerfile")

  @colour.notify 'Creating Autounattend.xml'
  templateGenerator.create_template_file("#{DIR_TEMPLATE}/Autounattend.xml.erb","#{options[:project_dir]}/Autounattend.xml")

  # TODO: Check if this is needed
  # @colour.notify 'Creating Provisioner_install.ps1.erb'
  # templateGenerator.create_template_file("#{DIR_TEMPLATE}/Provisioner_install.ps1.erb","#{options[:project_dir]}/Provisioner_install.ps1")

  @colour.notify 'Copying virtualbox_guest_additions_install_scripts to project directory'
  templateGenerator.cp_template("#{DIR_TEMPLATE}/virtualbox_guest_additions_install_scripts/windows.bat","#{options[:project_dir]}/windows.bat")

  @colour.notify 'Copying puppet_install_script to project directory'
  templateGenerator.cp_template("#{DIR_TEMPLATE}/puppet_install_scripts/windows.ps1","#{options[:project_dir]}/windows.ps1")

  # Validate Packerfile
  @colour.notify 'Validating generated Packerfile'
  exit 0 unless system "cd '#{options[:project_dir]}' && packer validate Packerfile"

  ## Vagrant
  # Generate Vagrantfile
  @colour.notify 'Creating Vagrantfile'
  templateGenerator.create_template_file("#{DIR_TEMPLATE}/Vagrantfile.erb","#{options[:project_dir]}/Vagrantfile")

  ## Puppet
  # Generate Puppetfile
  @colour.notify 'Creating Puppetfile'
  templateGenerator.create_template_file("#{DIR_TEMPLATE}/Puppetfile.erb","#{options[:project_dir]}/Puppetfile")

  ## XML
  outputGenerator = OutputGenerator.new(options, case_xml)

  # Generate XML output file
  @colour.notify 'Generating XML output file'
  outputGenerator.create_xml_output_file("#{options[:project_dir]}/CaseDetails.xml")

  ## Create puppet module structure withing project directory using librarian-puppet
  @colour.notify "Creating Puppet module structure using librarian-puppet for project #{options[:project_dir].split('/').last} (This may take a while)"
  exit 0 unless system "cd '#{options[:project_dir]}' && librarian-puppet install #{'--verbose' if options[:verbose]}"

  return options
end

#################################################
#################################################

# Make a vagrant basebox
#
# @param [Hash] options Main options hash containing all options for the running ForGen instance
#
# @author Jason Keighley
#
# @return [Hash] options Main options hash containing all options for the running ForGen instance
def make_vagrant_basebox(options)
  @colour.notify 'Creating Vagrant basebox'
  @colour.notify 'Executing packer build (this may take a while)'
# TODO: Sort out verbose mode for Packer
  exit 0 unless system "cd '#{options[:project_dir]}' && #{'PACKER_LOG=1' if options[:verbose]} packer build  #{'--debug' if options[:debug]} #{'-color=false' if options[:disable_colour]} Packerfile"

  return options
end

#################################################
#################################################

# Make all VirtualBox virtual machines
#
# @author Jason Keighley
# @param [Hash] options Main options hash containing all options for the running ForGen instance
# @return [Hash] options Main options hash containing all options for the running ForGen instance
def make_virtualbox_vm(options)
  @colour.notify "Ensuring following commands run from directory '#{options[:project_dir]}/Vagrantfile'"
  @colour.notify 'Executing vagrant up (this may take a while)'

  if options.has_key? :debug
    system "cd '#{options[:project_dir]}' && vagrant up --debug"
  else
    system "cd '#{options[:project_dir]}' && vagrant up"
  end

  return options
end

#################################################
#################################################

# Make forensic image helper methods
#################################################
# Create an EWF forensic image
#
# @author Jason Keighley
# @return [Void]
def create_ewf_image(drive_path ,image_output_location)
  ## Make E01 image
  @colour.notify "Creating E01 image with path #{image_output_location}.E01"
  @colour.notify 'This may take a while:'
  @colour.notify "E01 image #{image_output_location}.E01 created" if system "ftkimager '#{drive_path}' '#{image_output_location}' --e01"
end

# Create an DD forensic image
#
# @author Jason Keighley
# @return [Void]
def create_dd_image(drive_path, image_output_location)
  ## Make DD image
  @colour.notify "Creating dd image with path #{image_output_location}.raw"
  @colour.notify 'This may take a while:'
  @colour.notify "Raw image #{image_output_location}.raw created" if system "aBoxManage clonemedium disk '#{drive_path}' '#{image_output_location}.raw' --format RAW"
end

# Delete virtualbox virtual machine
#
# @author Jason Keighley
# @param [String] vm_name Virtual machine name in VirtualBox
# @return [Void]
def delete_virtualbox_vm(vm_name)
  @colour.notify "Deleting VirtualBox VM #{vm_name}"
  @colour.notify "VirtualBox VM #{vm_name} deleted" if system "VBoxManage unregistervm #{vm_name} --delete"
end

# Make forensic image helper methods \end
#################################################

# Make forensic image
#
# @author Jason Keighley
# @param [Hash] options Main options hash containing all options for the running ForGen instance
# @return [Hash] options Main options hash containing all options for the running ForGen instance
def make_forensic_image(options)
  drive_path = %x(VBoxManage list hdds | grep '#{options[:project_dir].split('/').last}').sub(/\ALocation:\s*/, '').sub(/\n/, '')
  # drive_path = %x(VBoxManage list hdds | grep '#{options[:project_dir].split('/').last}').sub(/\ALocation:\s*|\n\Z/, '')
  drive_name = drive_path.split('/').last

  options[:image_output_location] = "#{options[:project_dir]}/#{drive_name}".sub(/.vmdk|.vdi/, '') unless options.has_key? :image_output_location

  unless options.has_key? :no_vm_shutdown
    ## Ensure all vms are shutdown
    system "cd '#{options[:project_dir]}' && vagrant halt"

    if options.has_key? :create_raw_image
     create_dd_image(drive_path, options[:image_output_location])
    end

    if options.has_key? :create_ewf_image
      create_ewf_image(drive_path, options[:image_output_location])
    end

    if options.has_key? :delete_vm_after_image_creation
      delete_virtualbox_vm(options[:vm_name])
    end
  else
    @colour.error 'Cannot create forensic image as --no-vm-shutdown option is set to true'
  end

  return options
end

#################################################
#################################################

### Declare default variables
@colour = Colour.new
options = Hash.new
options[:vagrant_box_name] = 'Forgen_default_machine'
options[:virtualisation_provider] = 'VirtualBox'

opts = GetoptLong.new(
    # Help options
    [ '-h', '--help', GetoptLong::NO_ARGUMENT ],
    [ '--version', GetoptLong::NO_ARGUMENT ],

    # Case options
    [ '--case-path', GetoptLong::REQUIRED_ARGUMENT ],
    [ '--list-cases', GetoptLong::NO_ARGUMENT ],

    # Project options
    [ '--delete-all-projects', GetoptLong::NO_ARGUMENT ],
    [ '--project-dir', GetoptLong::REQUIRED_ARGUMENT ],

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
      exit 0

    when '--version'
      display_version
      exit 0

    # Case options
    when '--case-path'
      @colour.help "--case set to #{arg}"
      options[:case_path] = arg

    when '--list-cases'
      @colour.help 'Listing cases:'
      list_cases
      exit 0

    # Project options
    when '--delete-all-projects'
      @colour.help 'Deleting all projects'
      delete_all_projects
      exit 0

    when '--project-dir'
      @colour.help "--project-directory set to #{arg}"
      options[:project_dir] = arg

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
      exit 0

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
      # @colour.help '--disable-colouts set to true'
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
    @colour.notify 'Running all ForGen features'

    # TODO: Delete this, check no other code reliance
    # # Set Packer iso location to default [Windows server 2008] if not set (no base module selected)
    # options[:packer_iso_location] = '/home/user/Downloads/7601.17514.101119-1850_x64fre_server_eval_en-us-GRMSXEVAL_EN_DVD.iso'

    # Make configuration
    make_configuration(options)
    # Make Vagrant basebox (packer)
    make_vagrant_basebox(options)
    # Make Virtualbox image (vagrant)
    make_virtualbox_vm(options)
    # Make forensic image
    make_forensic_image(options)

    @colour.notify 'Run command finished'

  when 'make-configuration'
    @colour.notify 'Making configuration files'
    make_configuration(options)

  when 'make-vagrant-basebox'
    (@colour.error 'The option [--project-dir] needs to be set for the command [make-vagrant-basebox]'; exit 0;) unless options.has_key? :project_dir
    @colour.notify 'Making vagrant basebox'
    make_vagrant_basebox(options)

  when 'make-virtual-machine'
    (@colour.error 'The option [--project-dir] needs to be set for the command [make-virtual-machine]'; exit 0;) unless options.has_key? :project_dir
    @colour.notify 'Making virtual machine'
    make_vagrant_basebox(options)
    make_virtualbox_vm(options)

  when 'make-forensic-image'
    (@colour.error 'The option [--project-dir] needs to be set for the command [make-forensic-image]'; exit 0;) unless options.has_key? :project_dir
    (@colour.error 'The options [--create_ewf_image] or [--create_dd_image] need to be set for the command [make-forensic-image]'; exit 0;) unless options.has_key? (:create_ewf_image || :create_dd_image)
    @colour.notify 'Making forensic image'
    make_vagrant_basebox(options)
    make_virtualbox_vm(options)
    make_forensic_image(options)

  else
    @colour.error "[#{ARGV[0]}] is not a valid ForGen command"

  # options = make_test_sheets(options)
  # options = make_mark_sheets(options)

end