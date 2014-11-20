
module NessusREST

  module Folder

    #
    # Return array of folders
    #
    # @return [Array] folders
    def list_folders
      nessus_rest_get("folders")
    end

    #
    # Create a new folder
    #
    # @param name [String]
    #
    # @return [Hash] new older
    def folder_create(name)
      post_data = {:name => name}
      nessus_rest_post("folders", post_data)
    end

    #
    # Get folder details
    #
    # @param folder_id [Fixnum]
    #
    # @return [Hash] folder details
    def folder_get(folder_id)
      nessus_rest_get("folders/#{folder_id}")
    end

    #
    # Update folder details
    #
    # @param folder_id [Fixnum]
    # @param name [String]
    #
    # @return [Hash] updated folder
    def folder_update(folder_id, name)
      post_data = {:name => name, :folder_id => folder_id}
      nessus_rest_put("folders/#{folder_id}", post_data)
    end

    #
    # Delete folder
    #
    # @param folder_id [Fixnum]
    #
    # @return [Hash] confirmation/error
    def folder_delete(folder_id)
      nessus_rest_delete("folders/#{id}")
    end

  end

end

