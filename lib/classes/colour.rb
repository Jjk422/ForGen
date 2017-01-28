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

  def notify(text)
    output('puts','text_notify',text)
  end

  def help(text)
    output('puts','text_help',text)
  end

  def urgent(text)
    output('puts','text_urgent',text)
  end

  def error(text)
    output('puts','text_error',text)
  end

  def help_title(text)
    output('puts','bold_help',text)
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

  def underline(text)
    underline(text)
  end

end