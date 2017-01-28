# Selects, sorts, compares currently usable ForGen modules and
#
# @author Jason Keighley
# @since 0.0.1
# @attr_reader [Void]
# @attr_writer [Void]
class ModuleSelector
  def initialize(colour, options, xml_parse, case_hash)
    @colour = colour
    @options = options
    @case_hash = case_hash
    @xml_parse = xml_parse
  end

  def select_modules
    # Create array of desired modules from ruby hash
    desired_modules = Array.new
    @case_hash[:case].each_value do |system|
      desired_modules << system[:modules][:module]
    end

    # Get all forgen_metadata.xml paths
    forgen_metadata_paths = Dir["#{DIR_MODULES}/**/**/**/*"].select do
        |file| File.file?(file) && file.include?('forgen_metadata.xml')
    end

    # Parse all forgen_metadata.xml files
    module_hash = Array.new
    forgen_metadata_paths.each do |file_path|
      module_hash << @xml_parse.xml_file_to_hash(file_path)
    end

    # # TODO: Build in randomisation and move to different class
    # # TODO: Sort out module selection loop to allow for single module input via case schema selection, example below
    # # Compare and validate forgen files and desired module selections
    # selected_modules = Hash.new
    # module_hash.each do |module_type|
    #   module_type.each do |type, details|
    #     # Validate all modules against their individual xml schemas
    #     @colour.notify "Validating module '#{details[:path]}' against schema '#{type}.xsd'"
    #     validate_schema("#{DIR_MODULES}/#{details[:path]}/forgen_metadata.xml", "#{DIR_SCHEMA}/#{type}.xsd")
    #
    #     # Compare and select ForGen modules by comparing against given case xml
    #     @colour.notify "Checking if module '#{details[:path]}' matches configuration in #{options[:case_path]}"
    #     desired_modules.each do |desired_module_type|
    #
    #       @colour.error ''
    #       @colour.error "desired modules: #{desired_modules}"
    #       @colour.error ''
    #
    #       @colour.error ''
    #       @colour.error "desired modules type: #{desired_module_type}"
    #       @colour.error ''
    #
    #       if desired_modules.length == 1
    #         desired_module_type.each do |desired_module_details|
    #           if (desired_module_details.select{|k,v| details[k.to_sym] == v }.size >= options[:number_of_matching_conditions])
    #             @colour.notify "Module #{details[:path]} matches at least #{options[:number_of_matching_conditions]} desired conditions"
    #
    #             selected_modules["#{details[:type]}_#{details[:category]}_#{details[:name]}"] = details
    #           end
    #         end
    #       elsif desired_modules.length > 1
    #         if (desired_module_details.select{|k,v| details[k.to_sym] == v }.size >= options[:number_of_matching_conditions])
    #           @colour.notify "Module #{details[:path]} matches at least #{options[:number_of_matching_conditions]} desired conditions"
    #
    #           selected_modules["#{details[:type]}_#{details[:category]}_#{details[:name]}"] = details
    #         end
    #       else
    #         @colour.notify "No modules given"
    #
    #         selected_modules["#{details[:type]}_#{details[:category]}_#{details[:name]}"] = details
    #       end
    #     end
    #
    #   end
    # end


    # TODO: Reuse or remove old loop

    selected_modules = Hash.new
    module_hash.each do |module_type|
      module_type.each do |type, details|

        # Validate all modules against their individual xml schemas
        @colour.notify "Validating module '#{details[:path]}' against schema '#{type}.xsd'"
        validate_schema("#{DIR_MODULES}/#{details[:path]}/forgen_metadata.xml", "#{DIR_SCHEMA}/#{type}.xsd")

        # Compare and select ForGen modules by comparing against given case xml
        @colour.notify "Checking if module '#{details[:path]}' matches configuration in #{@options[:case_path]}"
        desired_modules.each do |desired_module_type|
          desired_module_type.each do |desired_module_details|
            if (desired_module_details.select{ |module_name, module_information| details[module_name.to_sym] == module_information }.size >= @options[:number_of_matching_conditions])
              @colour.urgent "Module #{details[:path]} matches at least #{@options[:number_of_matching_conditions]} desired conditions"

              # selected_modules["#{details[:type]}_#{details[:category]}_#{details[:name]}"] = details
              selected_modules["#{details[:path].gsub(/(\\|\/)/,'_').to_sym}"] = details
            end
          end
        end

      end
    end

    # Create modules hash
    @colour.notify "Selecting puppet configuration modules for project #{@options[:project_dir]}"
    config_modules = Hash.new
    base_module = nil

    selected_modules.each do |module_name, module_info|
      if (PUPPET_MODULE_TYPES.include?(module_info[:type]))
        config_modules["#{module_info[:provider]}".to_sym] = [] unless config_modules.has_key? ("#{module_info[:provider]}".to_sym)
        config_modules["#{module_info[:provider]}".to_sym] << { module_name.to_sym => module_info }
      end

      base_module = module_info if (Packer_ISO_TYPES.include?(module_info[:type]))
    end

    return base_module, config_modules

  end

end