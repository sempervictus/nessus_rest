
module NessusREST

  module Group

    VALID_FIELDS = %w{ id name permissions user_count }
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
    # Return array of groups
    #
    # @return [Array] groups
    def list_groups
      nessus_rest_get('groups')['groups'] || []
    end

    #
    # Return array of users in group
    #
    # @param group_id [Fixnum]
    #
    # @return [Array]
    def list_group_users(group_id)
      nessus_rest_get("groups/#{group_id}/users")['users'] || []
    end

    #
    # Delete work
    #
    # @param group_id [Fixnum]
    #
    # @return [Hash] confirmation/error
    def group_delete(group_id)
      nessus_rest_delete("groups/#{group_id}")
    end

    #
    # Create group
    #
    # @param name [String]
    # @param opts [Hash]
    #
    # @return [Hash] new group
    def group_create(name, opts = {})
      post_data = {:name => name}
      nessus_rest_post('groups',post_data.merge(validate_options(opts)))
    end

    #
    # Edit group
    #
    # @param group_id [Fixnum]
    # @param name [String]
    # @param opts [Hash]
    #
    # @return [Hash] updated group
    def group_update(group_id, name, opts = {})
      post_data = {:group_id => group_id, :name => name}
      nessus_rest_put("groups/#{group_id}", post_data.merge(validate_options(opts)))
    end

    #
    # Add user to group
    #
    # @param group_id [Fixnum]
    # @param user_id [Fixnum]
    # @param opts [Hash]
    #
    # @return [Hash] updated group membership
    def group_add_user(group_id, user_id, opts = {})
      post_data = {
        :group_id => group_id,
        :user_id  => user_id
      }
      nessus_rest_post("groups/#{group_id}/users", post_data.merge(validate_options(opts)))
    end

    #
    # Delete user from group
    #
    # @param group_id [Fixnum]
    # @param user_id [Fixnum]
    #
    # @return [Hash]
    def group_delete_user(group_id, user_id)
      post_data = {
        :group_id => group_id,
        :user_id  => user_id
      }
      nessus_rest_delete("groups/#{group_id}/users", post_data)
    end

  end
end

