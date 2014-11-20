
module NessusREST

  module PluginRule

    VALID_FIELDS = %w{id plugin_id date host type owner owner_id}

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
    # Return array of plugin rules
    #
    # @return [Array]
    def list_plugin_rules
      nessus_rest_get('plugin-rules')['plugin-rules']
    end

    #
    # Create a plugin rule
    #
    # @param plugin_id [Fixnum]
    # @param type [String]
    # @param host [String]
    # @param opts [Hash]
    #
    # @return [Hash] new rule
    def plugin_rule_create(plugin_id, type, host, opts = {} )
      post_data = {
        :plugin_id => plugin_id,
        :type => type,
        :host => host
      }
      nessus_rest_post('plugin-rules',post_data.merge(validate_options(opts)))
    end

    #
    # Edit a plugin rule
    #
    # @param rule_id [Fixnum]
    # @param plugin_id [Fixnum]
    # @param type [String]
    # @param host [String]
    # @param opts [Hash]
    #
    # @return [Hash] new rule
    def plugin_rule_update(rule_id, plugin_id, type, host, opts = {} )
      post_data = {
        :rule_id => rule_id,
        :plugin_id => plugin_id,
        :type => type,
        :host => host
      }
      nessus_rest_post("plugin-rules/#{rule_id}",post_data.merge(validate_options(opts)))
    end

    #
    # Delete a plugin rule
    #
    # @return [Hash]
    def plugin_rule_delete(rule_id)
      nessus_rest_delete("plugin-rules/#{rule_id}")
    end

  end

end

