# Main file generator class, all non template files are generated
# with this class
#
# @author Jason Keighley
# @since 0.0.1
# @!attribute [rw] :options Options hash containing all options data
class OutputGenerator
  attr_accessor :options

  # Initialisation method for the OutputGenerator class
  #
  # @author Jason Keighley
  # @param [Hash] options Options hash containing all command line options
  # @param [String] case_xml Contains all /case details in xml format
  def initialize(options, case_xml)
    @options = options
    @case_details = case_xml
  end

  # Create the xml output file from the case details
  # stored in the hash @case_details
  #
  # @author Jason Keighley
  # @param [String] output_file_path File path for the created xml file
  def create_xml_output_file(output_file_path)
    # puts @case_details

    xml_result = @case_details

    File.open(output_file_path, "w+") do |file|
      file.write(xml_result)
    end
  end
end