
module NessusREST

  module CiscoISE

    VALID_FIELDS = %w{ host port username password }

    include Util

    #
    # Return hash containing only keys in valid_options
    #
    # @param opts [Hash] unfiltered options
    # @param valid_options [Array] valid option keys
    #
    # @return [Hash] validated option set
    def validate_options(opts, valid_options = VALID_FIELDS)
      super(opts,valid_options)
    end

    #
    # Update connector information
    #
    # @param enabled [TrueClass, FalseClass]
    # @param acls [Array]
    # @param settings [Hash]
    #
    # @return [Hash] updated connector
    def ise_connector_update(enabled, acls = [], settings = {})
      post_data = { :enabled => enabled, :acls => acls }
      nessus_rest_post('connectors/cisco-ise', post_data.merge(validate_options(settings)))
    end

    #
    # Quarantine a host
    #
    # @param ip_address [String]
    #
    # @return [Hash]
    def ise_host_quarantine(ip_address)
      post_data = {:ip_address => ip_address}
      nessus_rest_post("connectors/cisco-ise/#{ip_address}/quarantine")
    end

    #
    # Unquarantine a host
    #
    # @param ip_address [String]
    #
    # @return [Hash]
    def ise_host_unquarantine(ip_address)
      post_data = {:ip_address => ip_address}
      nessus_rest_post("connectors/cisco-ise/#{ip_address}/unquarantine")
    end

    #
    # Get host info from ISE
    #
    # @param ip_address [String]
    #
    # @return [Hash]
    def ise_host_get(ip_address)
      post_data = {:ip_address => ip_address}
      nessus_rest_post("connectors/cisco-ise/#{ip_address}")
    end

    #
    # Get connector state information
    #
    # @return [Hash]
    def ise_connector_get
      nessus_rest_get('connectors/cisco-ise')
    end

  end

end
