
module NessusREST

  module Scanner

    #
    # Returns hash of available scanners
    #
    # @return [Hash]
    def list_scanners
      nessus_rest_get('scanners')
    end

  end

end

