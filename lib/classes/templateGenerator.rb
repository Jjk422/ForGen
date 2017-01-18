class TemplateGenerator
  attr_accessor :options

  def initialize(options, config_modules)
    @options = options
    @config_modules = config_modules
  end

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
end