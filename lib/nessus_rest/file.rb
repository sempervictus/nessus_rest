
module NessusREST

  module File

    #
    # Upload file
    #
    # @param encrypted [TrueClass, FalseClass]
    #
    # @return [Hash] confirmation
    def file_upload(encrypted = false)
      post_data = encrypted ? {:no_enc => 1} : {}
      nessus_rest_post("file/upload", post_data)
    end

  end

end

