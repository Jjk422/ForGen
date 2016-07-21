require 'nokogiri'

# validate an xml file with a xsd schema with the use of nokogiri
def validate_schema(xml_file_path, xsd_schema_path)
  xsd_file = Nokogiri::XML::Schema(File.read(xsd_schema_path))
  xml_file = Nokogiri::XML(File.read(xml_file_path))

  xsd_file.validate(xml_file).each do |error|
    puts error.message
  end
end

def parse_xml(xml_file_path)
  return Nokogiri::XML(File.open(xml_file_path)) do |config|
    config.strict.nonet
  end
end

def get_value(nokogiri_file, element_node)
  value_hash = Hash.new
  tmp_hash = Hash.new

  nokogiri_file.css("people #{element_node} *").each do |people|
    tmp_hash[people.name] = people.text
  end

  value_hash[element_node] = tmp_hash

  return value_hash
end

def get_all_values(nokogiri_file)
  puts get_value(nokogiri_file,'perpetrator')
  puts get_value(nokogiri_file,'victim')







  # i = 0
  # nokogiri_file.traverse {|node| print node; print i; i = i + 1; }

  # people_value_hash = Hash.new
  # tmp_hash = Hash.new

# puts '////////////////////////////////'
# nokogiri_file.css('victim name').each do |test|
#   puts test.content
# end
# puts '////////////////////////////////'




#   elements_arr = []
#
#   nokogiri_file.css('people *').each do |elements|
#     elements_arr << elements.name
#   end
# # puts elements_arr
#
#   nokogiri_file.css('people perpetrator *').each do |people|
#     tmp_hash[people.name] = people.text
#   end
#
#   people_value_hash['perpetrator'] = tmp_hash
#
#   # puts people_value_hash
#
#   elements_arr = []
#
#   nokogiri_file.css('people *').each do |elements|
#     elements_arr << elements.name
#   end
# # puts elements_arr
#
#   nokogiri_file.css('people victim *').each do |people|
#     tmp_hash[people.name] = people.text
#   end
#
#   people_value_hash['victim'] = tmp_hash
#
#   puts people_value_hash
#
#   # puts nokogiri_file.css('people').elements
#
# # puts nokogiri_file.elements
#
#
#   # I   - Get the main element name   <perpetrator,victim>
#   # II  - Get the sub element names   <name,age,connections,email>
#   # III - Get the sub element values  <Bob,28,Jenna,Bob@gmail.com>
#   # IV  - Store the sub element names and values in a hash {name=>Bob,age=>28,connections=>Jenna,email=>Bob@gmail.com}
#   # V   - Store the sub element hash in the main element hash
















  # puts '////////////////////////////////'
  # nokogiri_file.css('places *').each do |places|
  #   puts places.name
  #   puts places.content
  # end
  # puts '////////////////////////////////'
  # nokogiri_file.css('time *').each do |time|
  #   puts time.name
  #   puts time.content
  # end
  # puts '////////////////////////////////'
  #
  # nokogiri_file.css('case *').each do |element|
  #   puts element.name
  #   # puts element.content
  #
  #
  #
  # end
  #
  # puts '////////////////////////////////'
  #

end