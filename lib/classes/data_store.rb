# Creates data store to be used for test sheets, mark sheets
# and facter insertion.
#
# @author Jason Keighley
# @since 0.0.1
class DataStore
  # Example datastore
  # Datastore = [:name => [:person => [:male => ["Bob"], :female => ["Jill"]], :business => [:bank => ["Lloyds bank"]]]]

  # Example case_hash
  # {:case=>
  #   {:system=>
  #     {
  #       :information=>
  #         {
  #           :drive=>
  #             [
  #             {:name=>"C", :size=>"124"},
  #             {:name=>"D", :size=>"124"}
  #             ]
  #         },
  #       :crime=>
  #         {:type=>"criminal", :charge=>"robbery"},
  #       :people=>
  #         {
  #           :perpetrator=>
  #             {:name=>"Bob", :age=>"28", :connections=>"Jenna", :email=>"Bob@gmail.com"},
  #           :victim=>
  #             {:name=>"Jenna", :age=>"21", :connections=>"Bob", :email=>"Jenna@gmail.com"}
  #         },
  #       :places=>
  #           {
  #             :perpetrators_abode=>
  #               {:address=>"fwa"},
  #             :victims_abode=>
  #               {:address=>"af"},
  #             :crime_location=>
  #               {:address=>"asf"}
  #           },
  #       :time=>
  #         {:system_time=>nil, :lead_time=>nil, :lead_crime_time=>nil},
  #       :modules=>
  #         {:module=>
  #           [
  #           {:author=>"Jason Keighley", :type=>"software", :category=>"languages", :name=>"ruby", :path=>"software/languages/ruby", :description=>"Installs the ruby language"},
  #           {:author=>"Jason Keighley", :type=>"evidence", :category=>"fraud", :name=>"business_invoice_1", :path=>"evidence/fraud/business_invoice_1", :description=>nil},
  #           {:author=>"Jason Keighley", :type=>"software", :category=>"languages", :name=>"python", :path=>nil, :description=>nil},
  #           {:author=>"Jason Keighley", :type=>"software", :category=>"internet_browser", :name=>nil, :version=>nil, :path=>nil, :description=>nil},
  #           {:author=>"Jason Keighley", :type=>"software", :category=>"text_editor", :name=>"notepad++", :version=>nil, :path=>"software/text_editor/notepad++", :description=>"Installs notepad++"},
  #           {:author=>"Jason Keighley", :type=>"base", :category=>"windows", :name=>"windows_server_2008_r2", :distro=>"server", :version=>"2008", :path=>"baseboxes/windows/windows_server_2008_r2", :url=>"file:///home/user/Desktop/Baseboxes/Windows_2008_metasploitable/windows_2008_server_metasploitable.box", :description=>"Windows server 2008 r2"}
  #           ]
  #         }
  #       }
  #     }
  #   }

  # Initialisation method for the DataStore class
  #
  # @author Jason Keighley
  # @private
  # @param [Object] colour Colour object to print coloured output to console
  # @param [Hash] case_hash case_hash Hash containing all /case details
  # @return [void]
  def initialize(colour, case_hash)
    @colour = colour
    @case_hash = case_hash
    @datastore = Hash.new
  end

  # Method to parse given case hash to build and save to @datastore class variable
  #
  # @author Jason Keighley
  # @private
  # @return [Void]
  :private
  def parse_case_hash
    @case_hash.each_value do | system |
      system.each_value do | category |
        category.each do | category, category_information |
          unless category == :modules
            @datastore[category.to_sym] = Array.new
            @datastore[category.to_sym] << category_information
          end
        end
      end
    end
  end

  # Method to return the saved datastore from the DataStore class
  #
  # @author Jason Keighley
  # @public
  # @return [Hash] @datastore
  :public
  def get_datastore
    return @datastore
  end
end