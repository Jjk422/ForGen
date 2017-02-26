class TestGenerator
  attr_accessor :options

  # Initialisation method for the TestGenerator class
  #
  # @author Jason Keighley
  # @param [Hash] options Options hash containing all command line options
  # @param [Hash] case_hash Contains all /case details
  def initialize(options, case_hash)
    @options = options
    @case_details = case_hash
    @mark_data = Hash.new
  end

  private
  # Collect all information from the current
  # \case relating to the drives
  #
  # @author Jason Keighley
  # @return [Array] mark_data_drive_information Drive info to be printed to file
  def collect_drive_information
    ### Drive information
    mark_data_drive_information = Array.new
    drive_information = @case_details[:case][:system][:information][:drive]

    mark_data_drive_information << 'Answer the following about each drive on the system'
    drive_information.each do | drive |
      drive.each { | key, value | mark_data_drive_information << "-#{key.capitalize}::#{value}" }
      mark_data_drive_information << ''
    end

    return mark_data_drive_information
  end

  # Collect all information from the current
  # \case relating to the crimes
  #
  # @author Jason Keighley
  # @return [Array] mark_data_crime_information Crime info to be printed to file
  def collect_crime_information
    ### Crime information
    mark_data_crime_information = Array.new
    crime_information = @case_details[:case][:system][:crime]

    mark_data_crime_information << 'Answer the following about each crime present in the evidence on the system'
    crime_information.each do | key, value | mark_data_crime_information << "-#{key.capitalize}::#{value}"
    end
    mark_data_crime_information << ''

    return mark_data_crime_information
  end

  # Collect all information from the current
  # \case relating to the people
  #
  # @author Jason Keighley
  # @return [Array] mark_data_people_information People info to be printed to file
  def collect_people_information
    ### People information
    mark_data_people_information = Array.new
    people_information = @case_details[:case][:system][:people]

    mark_data_people_information << 'Answer the following about each person present in the evidence on the system'
    people_information.each do | person_category, person_information |
      mark_data_people_information << person_category.capitalize
      person_information.each { | key, value | mark_data_people_information << "-#{key.capitalize}::#{value}" }
      mark_data_people_information << ''
    end

    return mark_data_people_information
  end

  # Collect all information from the current
  # \case relating to the places
  #
  # @author Jason Keighley
  # @return [Array] mark_data_places_information Places info to be printed to file
  def collect_places_information
    ### Places information
    mark_data_places_information = Array.new
    places_information = @case_details[:case][:system][:places]

    mark_data_places_information << 'Answer the following about each places present in the evidence on the system'
    places_information.each do | place_category, place_information |
      mark_data_places_information << place_category.capitalize
      place_information.each { | key, value | mark_data_places_information << "-#{key.capitalize}::#{value}" }
      mark_data_places_information << ''
    end

    return mark_data_places_information
  end

  # Collect all information from the current
  # \case relating to the time
  #
  # @author Jason Keighley
  # @return [Array] mark_data_time_information Time info to be printed to file
  def collect_time_information
    ### Time information
    mark_data_time_information = Array.new
    time_information = @case_details[:case][:system][:time]

    mark_data_time_information << 'Answer the following about each time period present in the evidence on the system'
    time_information.each do | key, value | mark_data_time_information << "-#{key.capitalize}::#{value}"
    end
    mark_data_time_information << ''

    return mark_data_time_information
  end

  # Collect and concatenate all information to be printed to the test and mark files
  #
  # @author Jason Keighley
  # @return [Array] mark_file_content Information to be printed to the test and mark files
  def collect_mark_file_content
    @mark_data[:Drives] = collect_drive_information
    @mark_data[:Crimes] = collect_crime_information
    @mark_data[:People] = collect_people_information
    @mark_data[:Places] = collect_places_information
    @mark_data[:Time] = collect_time_information

    mark_file_content = @mark_data.flatten
    return mark_file_content
  end

  public

  # Create a test sheet containing questions to answer
  # that relate to the information on the generated
  # image file
  #
  # @author Jason Keighley
  # @param [String] test_output_file_path File path for the created test file
  def create_test_output_file(test_output_file_path)
    mark_file_content = collect_mark_file_content

    test_file_content = mark_file_content.map do | element |
      if element.kind_of?(Array)
        element.map! { |array_content| array_content.to_s.gsub(/::.*\z/,'::') }
      else
        element
      end
    end

    # Write test output contents to file.
    File.open(test_output_file_path, "w+") do |file|
      file.puts(test_file_content)
    end
  end

  # Create a mark sheet containing the answers to
  # questions given in the test output file
  #
  # @author Jason Keighley
  # @param [String] mark_output_file_path File path for the created marking file
  def create_mark_output_file(mark_output_file_path)
    # Write test output contents to file.
    File.open(mark_output_file_path, "w+") do |file|
      # file.write(collect_mark_file_content)

      file.puts(collect_mark_file_content)
    end
  end
end