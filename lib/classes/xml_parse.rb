class XMLParse
  def initialize(parser)
    @parser = parser
  end

  # Convert given file to ruby hash
  def xml_file_to_hash(file_path)
    return File.open(file_path) do |f|
      # Convert file elements to ruby hash
      @parser.parse(Nokogiri::XML(f).to_s)
    end
  end
end

