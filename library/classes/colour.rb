### TODO: Change code as taken from kpumuk.info and the answer on stackoverflow from user 'Veger'
class Colour
  private
  def initialize
    @disable_colours = false
  end

  def colour(text,colour_code)
    if @disable_colours == false
      "\e[#{colour_code}m#{text}\e[0m"
    else
      "#{text}"
    end
  end

  def underline(text); colour(text, "4");end
  def throughline(text); colour(text, "9");end

  def text_dark_grey(text); colour(text, "30");end
  def text_red(text); colour(text, "31");end
  def text_green(text); colour(text, "32");end
  def text_yellow(text); colour(text, "33");end
  def text_blue(text); colour(text, "34");end
  def text_purple(text); colour(text, "35");end
  def text_teal(text); colour(text, "36");end
  def text_light_grey(text); colour(text, "37");end

  def highlight_white(text); colour(text, "7");end
  def highlight_dark_grey(text); colour(text, "40");end
  def highlight_red(text); colour(text, "41");end
  def highlight_green(text); colour(text, "42");end
  def highlight_yellow(text); colour(text, "43");end
  def highlight_blue(text); colour(text, "44");end
  def highlight_purple(text); colour(text, "45");end
  def highlight_teal(text); colour(text, "46");end
  def highlight_light_grey(text); colour(text, "47");end

  def bold_grey(text); colour(text, "90");end
  def bold_red(text); colour(text, "91");end
  def bold_green(text); colour(text, "92");end
  def bold_yellow(text); colour(text, "93");end
  def bold_blue(text); colour(text, "94");end
  def bold_purple(text); colour(text, "95");end
  def bold_teal(text); colour(text, "96");end

  public
  ##### Output #####
  ### TODO: Need to sanitise string
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

  ##### Disable colours #####
  def disable_colours
    @disable_colours = true
  end

  ##### Text formats #####
  def text_error(text); text_red(text);end
  def text_notify(text); text_light_grey(text);end
  def text_help(text); text_green(text);end
  # def text_help(text); text_blue(text);end
  # def text_urgent(text); text_blue(text);end
  def text_urgent(text); text_green(text);end
  def text_caution(text); text_yellow(text);end

  ##### Highlight formats #####
  def highlight_error(text); highlight_red(text);end
  def highlight_notify(text); highlight_dark_grey(text);end
  def hightlight_help(text); hightlight_green(text);end
  def highlight_caution(text); highlight_yellow(text);end

  ##### Bold formats #####
  def bold_error(text); bold_red(text);end
  def bold_notify(text); bold_grey(text);end
  def bold_help(text); bold_green(text);end
  # def bold_help(text); bold_blue(text);end
  def bold_caution(text); bold_yellow(text);end

  def title(text)
    bold_green(text)
    # underline(text)
  end
























  # def puts_colour(text,colour_code)
  #   if @disable_colours == false
  #     puts "\e[#{colour_code}m#{text}\e[0m"
  #   else
  #     puts "#{text}"
  #   end
  # end
  #
  # def print_colour(text,colour_code)
  #   if @disable_colours == false
  #     print "\e[#{colour_code}m#{text}\e[0m"
  #   else
  #     print "#{text}"
  #   end
  # end
  #
  #
  # ### Puts formatting private
  # def puts_underline(text); puts_colour(text, "4");end
  # def puts_throughline(text); puts_colour(text, "9");end
  #
  # def puts_text_dark_grey(text); puts_colour(text, "30");end
  # def puts_text_red(text); puts_colour(text, "31");end
  # def puts_text_green(text); puts_colour(text, "32");end
  # def puts_text_yellow(text); puts_colour(text, "33");end
  # def puts_text_blue(text); puts_colour(text, "34");end
  # def puts_text_purple(text); puts_colour(text, "35");end
  # def puts_text_teal(text); puts_colour(text, "36");end
  # def puts_text_light_grey(text); puts_colour(text, "37");end
  #
  # def puts_highlight_white(text); puts_colour(text, "7");end
  # def puts_highlight_dark_grey(text); puts_colour(text, "40");end
  # def puts_highlight_red(text); puts_colour(text, "41");end
  # def puts_highlight_green(text); puts_colour(text, "42");end
  # def puts_highlight_yellow(text); puts_colour(text, "43");end
  # def puts_highlight_blue(text); puts_colour(text, "44");end
  # def puts_highlight_purple(text); puts_colour(text, "45");end
  # def puts_highlight_teal(text); puts_colour(text, "46");end
  # def puts_highlight_light_grey(text); puts_colour(text, "47");end
  #
  # def puts_bold_grey(text); puts_colour(text, "90");end
  # def puts_bold_red(text); puts_colour(text, "91");end
  # def puts_bold_green(text); puts_colour(text, "92");end
  # def puts_bold_yellow(text); puts_colour(text, "93");end
  # def puts_bold_blue(text); puts_colour(text, "94");end
  # def puts_bold_purple(text); puts_colour(text, "95");end
  # def puts_bold_teal(text); puts_colour(text, "96");end
  #
  #
  # ### Print formatting
  # def print_underline(text); print_colour(text, "4");end
  # def print_throughline(text); print_colour(text, "9");end
  #
  # def print_text_dark_grey(text); print_colour(text, "30");end
  # def print_text_red(text); print_colour(text, "31");end
  # def print_text_green(text); print_colour(text, "32");end
  # def print_text_yellow(text); print_colour(text, "33");end
  # def print_text_blue(text); print_colour(text, "34");end
  # def print_text_purple(text); print_colour(text, "35");end
  # def print_text_teal(text); print_colour(text, "36");end
  # def print_text_light_grey(text); print_colour(text, "37");end
  #
  # def print_highlight_white(text); print_colour(text, "7");end
  # def print_highlight_dark_grey(text); print_colour(text, "40");end
  # def print_highlight_red(text); print_colour(text, "41");end
  # def print_highlight_green(text); print_colour(text, "42");end
  # def print_highlight_yellow(text); print_colour(text, "43");end
  # def print_highlight_blue(text); print_colour(text, "44");end
  # def print_highlight_purple(text); print_colour(text, "45");end
  # def print_highlight_teal(text); print_colour(text, "46");end
  # def print_highlight_light_grey(text); print_colour(text, "47");end
  #
  # def print_bold_grey(text); print_colour(text, "90");end
  # def print_bold_red(text); print_colour(text, "91");end
  # def print_bold_green(text); print_colour(text, "92");end
  # def print_bold_yellow(text); print_colour(text, "93");end
  # def print_bold_blue(text); print_colour(text, "94");end
  # def print_bold_purple(text); print_colour(text, "95");end
  # def print_bold_teal(text); print_colour(text, "96");end
  #
  #
  # ### Return formatting private
  # def return_underline(text); colour(text, "4");end
  # def return_throughline(text); colour(text, "9");end
  #
  # def return_text_dark_grey(text); colour(text, "30");end
  # def return_text_red(text); colour(text, "31");end
  # def return_text_green(text); colour(text, "32");end
  # def return_text_yellow(text); colour(text, "33");end
  # def return_text_blue(text); colour(text, "34");end
  # def return_text_purple(text); colour(text, "35");end
  # def return_text_teal(text); colour(text, "36");end
  # def return_text_light_grey(text); colour(text, "37");end
  #
  # def return_highlight_white(text); colour(text, "7");end
  # def return_highlight_dark_grey(text); colour(text, "40");end
  # def return_highlight_red(text); colour(text, "41");end
  # def return_highlight_green(text); colour(text, "42");end
  # def return_highlight_yellow(text); colour(text, "43");end
  # def return_highlight_blue(text); colour(text, "44");end
  # def return_highlight_purple(text); colour(text, "45");end
  # def return_highlight_teal(text); colour(text, "46");end
  # def return_highlight_light_grey(text); colour(text, "47");end
  #
  # def return_bold_grey(text); colour(text, "90");end
  # def return_bold_red(text); colour(text, "91");end
  # def return_bold_green(text); colour(text, "92");end
  # def return_bold_yellow(text); colour(text, "93");end
  # def return_bold_blue(text); colour(text, "94");end
  # def return_bold_purple(text); colour(text, "95");end
  # def return_bold_teal(text); colour(text, "96");end
  #
  #
  # public
  #
  # ### Puts formatting
  # def puts_text_error(text); puts_text_red(text);end
  # def puts_text_notify(text); puts_text_light_grey(text);end
  #
  # #####
  # def puts_text_help(text); puts_text_green(text);end
  # # def puts_text_help(text); puts_text_blue(text);end
  # #####
  #
  # #####
  # # def puts_text_urgent(text); puts_text_blue(text);end
  # def puts_text_urgent(text); puts_text_green(text);end
  # #####
  #
  # def puts_highlight_error(text); puts_highlight_red(text);end
  # def puts_highlight_notify(text); puts_highlight_dark_grey(text);end
  # def puts_hightlight_help(text); puts_hightlight_green(text);end
  #
  # def puts_bold_error(text); puts_bold_red(text);end
  # def puts_bold_notify(text); puts_bold_grey(text);end
  #
  # #####
  # def puts_bold_help(text); puts_bold_green(text);end
  # # def puts_bold_help(text); puts_bold_blue(text);end
  # #####
  #
  # def puts_title(text)
  #   puts_bold_green(text)
  #   # underline(text)
  # end
  #
  # ### Print formatting public
  # def print_text_error(text); print_text_red(text);end
  # def print_text_notify(text); print_text_light_grey(text);end
  # def print_text_help(text); print_text_green(text);end
  # def print_text_urgent(text); print_text_blue(text);end
  #
  # def print_highlight_error(text); print_highlight_red(text);end
  # def print_highlight_notify(text); print_highlight_dark_grey(text);end
  # def print_hightlight_help(text); print_hightlight_blue(text);end
  #
  # def print_bold_error(text); print_bold_red(text);end
  # def print_bold_notify(text); print_bold_grey(text);end
  #
  # def print_bold_help(text); print_bold_green(text);end
  #
  # def print_title(text)
  #   print_text_blue(text)
  #   # underline(text)
  # end
  #
  # ### Return formatting public
  # def return_text_error(text); return_text_red(text);end
  # def return_text_notify(text); return_text_light_grey(text);end
  # def return_text_help(text); return_text_green(text);end
  # def return_text_urgent(text); return_text_blue(text);end
  #
  # def return_highlight_error(text); return_highlight_red(text);end
  # def return_highlight_notify(text); return_highlight_grey(text);end
  # def return_hightlight_help(text); return_hightlight_blue(text);end
  #
  # def return_title(text)
  #   return_text_blue(text)
  #   # underline(text)
  # end


  #   def text_error(text, output_type);
  #     case output_type
  #       when 'print'
  #         print_
  # end
  #   end

  # @text_error = 'text_red'


  # def text_error(text, output_type)
  #   print_
  # end





  # def underline(text); colour(text, "4");end
  # def throughline(text); colour(text, "9");end
  #
  # def text_dark_grey(text); colour(text, "30");end
  # def text_red(text); colour(text, "31");end
  # def text_green(text); colour(text, "32");end
  # def text_yellow(text); colour(text, "33");end
  # def text_blue(text); colour(text, "34");end
  # def text_purple(text); colour(text, "35");end
  # def text_teal(text); colour(text, "36");end
  # def text_light_grey(text); colour(text, "37");end
  #
  # def highlight_white(text); colour(text, "7");end
  # def highlight_dark_grey(text); colour(text, "40");end
  # def highlight_red(text); colour(text, "41");end
  # def highlight_green(text); colour(text, "42");end
  # def highlight_yellow(text); colour(text, "43");end
  # def highlight_blue(text); colour(text, "44");end
  # def highlight_purple(text); colour(text, "45");end
  # def highlight_teal(text); colour(text, "46");end
  # def highlight_light_grey(text); colour(text, "47");end
  #
  # def bold_grey(text); colour(text, "90");end
  # def bold_red(text); colour(text, "91");end
  # def bold_green(text); colour(text, "92");end
  # def bold_yellow(text); colour(text, "93");end
  # def bold_blue(text); colour(text, "94");end
  # def bold_purple(text); colour(text, "95");end
  # def bold_teal(text); colour(text, "96");end
  #
  # def text_error(text); text_red(text);end
  # def text_notify(text); text_dark_grey(text);end
  # def text_help(text); text_blue(text);end
  #
  # def highlight_error(text); highlight_red(text);end
  # def highlight_notify(text); highlight_dark_grey(text);end
  # def hightlight_help(text); hightlight_blue(text);end
  #
  # def title(text)
  #   text_blue(text)
  #   # underline(text)
  # end
end