class OutputGenerator
  attr_accessor :options

  # Initialise the output generator with all the case
  # information given in the case hash [case_hash] and
  # any options given in the options hash [options]
  def initialize(options, case_hash)
    @options = options
    @case_details = case_hash
  end

  # Create the xml output file from the case details
  # stored in the hash @case_details
  def create_xml_output_file(output_file_path)
    # puts @case_details

    xml_result = @case_details

    File.open(output_file_path, "w+") do |file|
      file.write(xml_result)
    end
  end

  # # Create a test sheet containing questions to answer
  # # that relate to the information on the generated
  # # image file
  # def create_test_output_file(test_output_file_path)
  #
  # end
  #
  # # Create a mark sheet containing the answers to
  # # questions given in the test output file
  # def create_mark_output_file(mark_output_file_path)
  #
  # end
end