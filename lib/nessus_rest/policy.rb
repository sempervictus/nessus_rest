
module NessusREST

  module Policy

    VALID_FIELDS = %w{id template_uuid name description owner_id owner
      shared user_permissions creation_date last_modification_date
      visibility no_target
    }

    include Util

    def validate_options(opts, valid_options = VALID_FIELDS)
      # super(opts,valid_options)
      # TODO: create policy validator
      opts
    end

    #
    # Get array of available policies
    #
    # @return [Array]
    def list_policies
      nessus_rest_get('policies')['policies']
    end

    #
    # Edit policy
    #
    # @param policy_id [Fixnum]
    # @param settings [Hash]
    #
    # @return [Hash]
    def policy_update(policy_id, settings = {})
      post_data = { :uuid => policy_id }
      nessus_rest_post("policies/#{policy_id}", post_data.merge(settings)) #validate_options(settings)))
    end

    #
    # Create new policy
    #
    # @param settings [Hash]
    #
    # @return [Hash] new policy
    def policy_create(settings = {})
      post_data = { :uuid => policy_id }
      nessus_rest_post("policies", post_data.merge(settings)) #validate_options(settings)))
    end

    #
    # Copy policy
    #
    # @param policy_id [Fixnum]
    #
    # @return [Hash]
    def policy_copy(policy_id)
      post_data = { :policy_id => policy_id }
      nessus_rest_post("policies/#{policy_id}/copy", post_data)
    end

    #
    # Delete policy
    #
    # @param policy_id [Fixnum]
    #
    # @ return [Hash] confirmation
    def policy_delete(policy_id)
      post_data = { :policy_id => policy_id }
      nessus_rest_delete("policies/#{policy_id}/delete", post_data)
    end

    #
    # Get policy data
    #
    # @param policy_id [Fixnum]
    #
    # @return [Hash] policy data
    def policy_get(policy_id)
      post_data = { :policy_id => policy_id }
      nessus_rest_get("policies/#{policy_id}", post_data)
    end

    #
    # Import policy data
    #
    # @param file_id [Fixnum]
    #
    # @return [Hash]
    def policy_import(file_id)
      post_data(:file => file_id)
      nessus_rest_post('policies/import', post_data)
    end

    #
    # Export policy data
    #
    # @param policy_id [Fixnum]
    #
    # @return [Hash] export confirmation
    def policy_export(policy_id)
      nessus_rest_get("policies/#{policy_id}/export")
    end

    #
    # Get plugin data
    #
    # @input policy_id [Fixnum]
    # @input family_id [Fixnum]
    # @input plugin_id [Fixnum]
    #
    # @return [Hash] plugin data
    def policy_get_plugin(policy_id, family_id, plugin_id)
      nessus_rest_get("editor/policy/#{policy_id}/families/#{family_id}/plugins/#{plugin_id}")
    end
  end
end

