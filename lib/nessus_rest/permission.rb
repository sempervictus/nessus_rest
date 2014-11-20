
module NessusREST

  module Permission

    #
    # Get permission data
    #
    # @input object_id [Fixnum]
    # @input object_type [String]
    #
    # @output [Hash] permission data
    def permission_get(object_id, object_type = 'scanner')
      nessus_rest_get("permissions/#{object_type}/#{object_id}")
    end

    #
    # Update permissions
    #
    # @input object_id [Fixnum]
    def permission_update(object_id, settings = {}, object_type = 'scanner')
      nessus_rest_put("permissions/#{object_type}/#{object_id}", settings)
    end

  end

end

