
module NessusREST

  module Server

    #
    # Return current server information
    #
    # @return [Hash] server data
    def server_get
      nessus_rest_get('server/properties')
    end

    #
    # Return current server status
    #
    # @return [Hash] server status
    def server_status
      nessus_rest_get('server/status')
    end

  end

end

