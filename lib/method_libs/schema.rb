# Validates an xml file with a xsd schema with the use of nokogiri
#
# @author Jason Keighley
# @param [String] xml_file_path File path to the xml file
# @param [String] xsd_schema_path File path to the schema file
# @return [String] xml_file Contents of the xml file
# @return [Array] error Array containing any errors that occurred
def validate_schema(xml_file_path, xsd_schema_path)
  xsd_file = Nokogiri::XML::Schema(File.read(xsd_schema_path))
  xml_file = Nokogiri::XML(File.read(xml_file_path))

  error = Array.new << xsd_file.validate(xml_file).each do |error|
    @colour.error error.message
  end

  return xml_file, error
end