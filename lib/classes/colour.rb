# Main stdout class, prints to console using given colour
#
# @author Jason Keighley
# @since 0.0.1
class Colour
  private
  # Initialisation method for the Colour class
  #
  # @author Jason Keighley
  # @return [void]
  def initialize
    @disable_colours = false
  end

  # Method to add formatting colour characters to inputted text
  #
  # @author Jason Keighley
  # @param [String] text Text to be outputted to stdout
  # @param [String] colour_code Colour code to be added to the input text
  # @return [String] formatted_text_output Formatted text to be passed to stdout
  def colour(text,colour_code)
    if @disable_colours == false
      "\e[#{colour_code}m#{text}\e[0m"
    else
      "#{text}"
    end
  end

  # Underline colour sub-method for class Colour
  #
  # @author Jason Keighley
  # @param [String] text Text to be outputted to stdout
  # @return [Void]
  def underline(text); colour(text, '4');end

  # Throughline colour sub-method for class Colour
  #
  # @author Jason Keighley
  # @param [String] text Text to be outputted to stdout
  # @return [Void]
  def throughline(text); colour(text, '9');end

  # Dark grey text colour sub-method for class Colour
  #
  # @author Jason Keighley
  # @param [String] text Text to be outputted to stdout
  # @return [Void]
  def text_dark_grey(text); colour(text, '30');end

  # Red text colour sub-method for class Colour
  #
  # @author Jason Keighley
  # @param [String] text Text to be outputted to stdout
  # @return [Void]
  def text_red(text); colour(text, '31');end

  # Green text colour sub-method for class Colour
  #
  # @author Jason Keighley
  # @param [String] text Text to be outputted to stdout
  # @return [Void]
  def text_green(text); colour(text, '32');end

  # Yellow text sub-method for class Colour
  #
  # @author Jason Keighley
  # @param [String] text Text to be outputted to stdout
  # @return [Void]
  def text_yellow(text); colour(text, '33');end

  # Blue text colour sub-method for class Colour
  #
  # @author Jason Keighley
  # @param [String] text Text to be outputted to stdout
  # @return [Void]
  def text_blue(text); colour(text, '34');end

  # Purple text colour sub-method for class Colour
  #
  # @author Jason Keighley
  # @param [String] text Text to be outputted to stdout
  # @return [Void]
  def text_purple(text); colour(text, '35');end

  # Light grey text colour sub-method for class Colour
  #
  # @author Jason Keighley
  # @param [String] text Text to be outputted to stdout
  # @return [Void]
  def text_light_grey(text); colour(text, '37');end

  # Highlighted white text colour sub-method for class Colour
  #
  # @author Jason Keighley
  # @param [String] text Text to be outputted to stdout
  # @return [Void]
  def highlight_white(text); colour(text, '7');end

  # Highlighted dark grey text colour sub-method for class Colour
  #
  # @author Jason Keighley
  # @param [String] text Text to be outputted to stdout
  # @return [Void]
  def highlight_dark_grey(text); colour(text, '40');end

  # Highlighted red text colour sub-method for class Colour
  #
  # @author Jason Keighley
  # @param [String] text Text to be outputted to stdout
  # @return [Void]
  def highlight_red(text); colour(text, '41');end

  # Highlighted green text colour sub-method for class Colour
  #
  # @author Jason Keighley
  # @param [String] text Text to be outputted to stdout
  # @return [Void]
  def highlight_green(text); colour(text, '42');end

  # Highlighted yellow text colour sub-method for class Colour
  #
  # @author Jason Keighley
  # @param [String] text Text to be outputted to stdout
  # @return [Void]
  def highlight_yellow(text); colour(text, '43');end

  # Highlighted blue text colour sub-method for class Colour
  #
  # @author Jason Keighley
  # @param [String] text Text to be outputted to stdout
  # @return [Void]
  def highlight_blue(text); colour(text, '44');end

  # Highlighted purple text colour sub-method for class Colour
  #
  # @author Jason Keighley
  # @param [String] text Text to be outputted to stdout
  # @return [Void]
  def highlight_purple(text); colour(text, '45');end

  # Hghlighted teal text colour sub-method for class Colour
  #
  # @author Jason Keighley
  # @param [String] text Text to be outputted to stdout
  # @return [Void]
  def highlight_teal(text); colour(text, '46');end

  # Highlight light grey text colour sub-method for class Colour
  #
  # @author Jason Keighley
  # @param [String] text Text to be outputted to stdout
  # @return [Void]
  def highlight_light_grey(text); colour(text, '47');end

  # Bold grey text colour sub-method for class Colour
  #
  # @author Jason Keighley
  # @param [String] text Text to be outputted to stdout
  # @return [Void]
  def bold_grey(text); colour(text, '90');end

  # Bold red text colour sub-method for class Colour
  #
  # @author Jason Keighley
  # @param [String] text Text to be outputted to stdout
  # @return [Void]
  def bold_red(text); colour(text, '91');end

  # Bold green text colour sub-method for class Colour
  #
  # @author Jason Keighley
  # @param [String] text Text to be outputted to stdout
  # @return [Void]
  def bold_green(text); colour(text, '92');end

  # Bold yellow text colour sub-method for class Colour
  #
  # @author Jason Keighley
  # @param [String] text Text to be outputted to stdout
  # @return [Void]
  def bold_yellow(text); colour(text, '93');end

  # Bold blue text colour sub-method for class Colour
  #
  # @author Jason Keighley
  # @param [String] text Text to be outputted to stdout
  # @return [Void]
  def bold_blue(text); colour(text, '94');end

  # Bold purple text colour sub-method for class Colour
  #
  # @author Jason Keighley
  # @param [String] text Text to be outputted to stdout
  # @return [Void]
  def bold_purple(text); colour(text, '95');end

  # Bold teal text colour sub-method for class Colour
  #
  # @author Jason Keighley
  # @param [String] text Text to be outputted to stdout
  # @return [Void]
  def bold_teal(text); colour(text, '96');end

  public
  ##### Output #####
  ### TODO: Need to sanitise string
  # Output selector method, selects and outputs formatted text by given
  # output_type
  #
  # @author Jason Keighley
  # @param [String] output_type Output type ('print', 'puts', 'return'),
  # print: prints without newline, puts: prints with newline
  # , return: return without printing to console
  # @param [String] function_to_call Method to call, e.g. blue_teal
  # @param [String] text Text to be outputted to stdout
  # @return [String] formatted_text Formatted text with embedded colour codes
  def output(output_type, function_to_call, text)
    case output_type
      when 'print'
        print send(function_to_call, text)
      when 'puts'
        puts send(function_to_call, text)
      when 'return'
        return send(function_to_call,text)
      else
        puts text_error("The output type #{output_type} was not recognised, please use either print,puts or return")
    end
  end

  # Public caller method to print text with newline
  # for notify situation
  #
  # @author Jason Keighley
  # @param [String] text Text to be outputted to stdout
  # @return [Void]
  def notify(text)
    output('puts','text_notify',text)
  end

  # Public caller method to print text with newline
  # for help situation
  #
  # @author Jason Keighley
  # @param [String] text Text to be outputted to stdout
  # @return [Void]
  def help(text)
    output('puts','text_help',text)
  end

  # Public caller method to print text with newline
  # for urgent situation
  #
  # @author Jason Keighley
  # @param [String] text Text to be outputted to stdout
  # @return [Void]
  def urgent(text)
    output('puts','text_urgent',text)
  end

  # Public caller method to print text with newline
  # for error situation
  #
  # @author Jason Keighley
  # @param [String] text Text to be outputted to stdout
  # @return [Void]
  def error(text)
    output('puts','text_error',text)
  end

  # Public caller method to print text with newline
  # for help title situation
  #
  # @author Jason Keighley
  # @param [String] text Text to be outputted to stdout
  # @return [Void]
  def help_title(text)
    output('puts','bold_help',text)
  end

  ##### Disable colours #####

  # Set class Colour disable_colours variable to true
  #
  # @author Jason Keighley
  # @return [Void]
  def disable_colours
    @disable_colours = true
  end

  ##### Text formats #####
  # Public caller method to print text with newline
  # for text error situation
  #
  # @author Jason Keighley
  # @param [String] text Text to be outputted to stdout
  # @return [Void]
  def text_error(text); text_red(text);end

  # Public caller method to print text with newline
  # for text notify situation
  #
  # @author Jason Keighley
  # @param [String] text Text to be outputted to stdout
  # @return [Void]
  def text_notify(text); text_light_grey(text);end

  # Public caller method to print text with newline
  # for text help situation
  #
  # @author Jason Keighley
  # @param [String] text Text to be outputted to stdout
  # @return [Void]
  def text_help(text); text_green(text);end

  # Public caller method to print text with newline
  # for text urgent situation
  #
  # @author Jason Keighley
  # @param [String] text Text to be outputted to stdout
  # @return [Void]
  def text_urgent(text); text_green(text);end

  # Public caller method to print text with newline
  # for text caution situation
  #
  # @author Jason Keighley
  # @param [String] text Text to be outputted to stdout
  # @return [Void]
  def text_caution(text); text_yellow(text);end

  ##### Highlight formats #####

  # Public caller method to print text with newline
  # for highlight error situation
  #
  # @author Jason Keighley
  # @param [String] text Text to be outputted to stdout
  # @return [Void]
  def highlight_error(text); highlight_red(text);end

  # Public caller method to print text with newline
  # for highlight notify situation
  #
  # @author Jason Keighley
  # @param [String] text Text to be outputted to stdout
  # @return [Void]
  def highlight_notify(text); highlight_dark_grey(text);end

  # Public caller method to print text with newline
  # for highlight help situation
  #
  # @author Jason Keighley
  # @param [String] text Text to be outputted to stdout
  # @return [Void]
  def hightlight_help(text); highlight_green(text);end

  # Public caller method to print text with newline
  # for highlight caution situation
  #
  # @author Jason Keighley
  # @param [String] text Text to be outputted to stdout
  # @return [Void]
  def highlight_caution(text); highlight_yellow(text);end

  ##### Bold formats #####

  # Public caller method to print text with newline
  # for bold error situation
  #
  # @author Jason Keighley
  # @param [String] text Text to be outputted to stdout
  # @return [Void]
  def bold_error(text); bold_red(text);end

  # Public caller method to print text with newline
  # for bold notify situation
  #
  # @author Jason Keighley
  # @param [String] text Text to be outputted to stdout
  # @return [Void]
  def bold_notify(text); bold_grey(text);end

  # Public caller method to print text with newline
  # for bold help situation
  #
  # @author Jason Keighley
  # @param [String] text Text to be outputted to stdout
  # @return [Void]
  def bold_help(text); bold_green(text);end

  # Public caller method to print text with newline
  # for bold caution situation
  #
  # @author Jason Keighley
  # @param [String] text Text to be outputted to stdout
  # @return [Void]
  def bold_caution(text); bold_yellow(text);end

  # Public caller method to print text with newline
  # for text underline situation
  #
  # @author Jason Keighley
  # @param [String] text Text to be outputted to stdout
  # @return [Void]
  def text_underline(text); underline(text);end

end