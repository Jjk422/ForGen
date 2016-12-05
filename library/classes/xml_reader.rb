class Xml_Reader
  attr_accessor :xml_object

  require 'xmlsimple'

  def read_file file_name
    return XmlSimple.xml_in(file_name, { 'KeyAttr' => 'name' })
  end
end