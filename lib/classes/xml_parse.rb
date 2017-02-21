# Class to parse XML in files
#
# @author Jason Keighley
# @since 0.0.1
class XMLParse
  # Initialisation method for the XMLParse class
  #
  # @author Jason Keighley
  # @param [Object] parser Nori parser object to convert xml to ruby hash
  # @return [void]
  def initialize(parser)
    @parser = parser
  end

  # Convert given XML file to ruby hash
  #
  # @author Jason Keighley
  # @param [String] file_path Path to the file to parse
  # @return [Hash] XML data in file converted to ruby hash
  def xml_file_to_hash(file_path)
    return File.open(file_path) do |f|
      # Convert file elements to ruby hash
      @parser.parse(Nokogiri::XML(f).to_s)
    end
  end
end

