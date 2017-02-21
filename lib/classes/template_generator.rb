# Main template generator class, parses and manages template files
#
# @author Jason Keighley
# @since 0.0.1
# @!attribute [rw] :options Options hash containing all options data
class TemplateGenerator
  attr_accessor :options

  # Initialisation method for the TemplateGenerator class
  #
  # @author Jason Keighley
  # @param [Hash] options Options hash containing all command line options
  # @param [Hash] config_modules Contains all configuration modules details
  # @return [void]
  def initialize(options, config_modules)
    @options = options
    @config_modules = config_modules
  end

  # Parse ERB template file and create output file on local system
  #
  # @author Jason Keighley
  # @param [String] template_file_path Full file path to the erb file to parse
  # @param [String] output_file_path File path to to save the output file to
  # @return [void]
  def create_template_file(template_file_path, output_file_path)
    # Read and parse erb file, return result and save to variable erb_binding.
    # The third erb parameter ['-'] tells erb to use trim mode, allowing for
    # the use of the -%> (- symbol) which stops newlines being created for
    # conditional statements in the erb file.
    erb_result = ERB.new(File.read("#{template_file_path}"), nil, '-').result(binding)

    # Write erb output to file.
    File.open(output_file_path, "w+") do |file|
      file.write(erb_result)
    end
  end

  # Copy a template file directly without parsing it
  #
  # @author Jason Keighley
  # @param [String] template_file_path Full file path to the erb file to parse
  # @param [String] output_file_path File path to to save the output file to
  # @return [void]
  def cp_template(template_file_path, output_file_path)
    FileUtils.cp template_file_path, output_file_path
  end
end