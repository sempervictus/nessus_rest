
module NessusREST

  module Scan

    VALID_FIELDS = %w{ 
      name description emails launch folder_id
      policy_id scanner_id text_targets
    }

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
    # Return array of scans
    #
    # @return [Array] session accessible scans
    def list_scans
      nessus_rest_get('scans')['scans']
    end

    #
    # Return array of folders from accessible scans
    #
    # @return [Array] folders in session accesible scans
    def list_folders
      nessus_rest_get('scans')['folders']
    end 

    #
    # Return array of host IDs and hostnames for scan
    #
    # @param scan_id [Fixnum] ID from which to find hosts
    #
    # @return [Array] hosts in scan
    def list_hosts(scan_id)
      hosts = scan_get(scan_id).to_hash['hosts']
      hosts.map {|h| {h['host_id'] => h['hostname'] }}
    end

    #
    # Return array of timezones
    #
    # @return [Array] known timezones
    def list_timezones
      nessus_rest_get('scans/timezones')['timezones']
    end

    #
    # Return hash of scan data
    #
    # @param id [String]
    #
    # @return [Hash] scan data
    def scan_get(id)
      nessus_rest_get("scans/#{id}")
    end

    #
    # Return attachment information for scan report
    #
    # @param scan_id [Fixnum]
    # @param file_id [Fixnum]
    #
    # @return [Hash] response headers
    def scan_download(scan_id, file_id)
      nessus_rest_get("scans/#{scan_id}/export/#{file_id}/download")
    end

    #
    # Return hash with file export pointer
    #
    # @param scan_id [Fixnum] 
    # @param format [String] report format
    # @param opts [Hash] additional options
    #
    # @return [Hash] file pointer
    def scan_export(scan_id, format = 'nessus', opts = {})
      post_data = {
        :scan_id => scan_id,
        :format => format.downcase
      }
      nessus_rest_post("scans/#{id}/export", 
                       post_data.merge(validate_options(opts,%w{password chapters history_id})))
    end

    #
    # Return hash with import data
    #
    # @param file [String]
    # @param password [String] encryption password
    #
    # @return [Hash]
    def scan_import(file, password = nil)
      post_data = {:file => file}
      if password and ! password.empty?
        post_data.merge!(:password => password)
      end
      nessus_rest_post("scans/import",post_data)
    end

    #
    # Return hash with scan UUID
    #
    # @param template_id [Fixnum]
    # @param settings [Hash]
    #
    # @return [Hash] scan info
    def scan_create(template_id, settings = {})
      post_data = { :uuid => template_id }
      nessus_rest_post('scans', post_data.merge(validate_options(settings)))
    end

    #
    # Return hash with updated scan information
    #
    # @param scan_id [Fixnum]
    # @param settings [Hash]
    #
    # @return [Hash] updated scan data
    def scan_update(scan_id, settings = {})
      post_data = { :uuid => scan_id }
      nessus_rest_post("scans/#{scan_id}", post_data.merge(validate_options(settings)))
    end

    #
    # Return hash with scan state
    #
    # @param id [Fixnum] scan ID
    #
    # @return [Hash] scan status
    %w{launch pause status resume stop}.each do |meth|
      define_method("scan_#{meth}") do |id|
        nessus_rest_post("scans/#{id}/#{meth}", :scan_id => id)
      end
    end

    #
    # Return hash with export status
    #
    # @param scan_id [Fixnum]
    # @param file_id [Fixnum]
    #
    # @return [Hash]
    def scan_export_status(scan_id, file_id)
      nessus_rest_get("scans/#{scan_id}/export/#{file_id}/status")
    end

    #
    # Return hash of host details from scan
    #
    # @param scan_id [Fixnum]
    # @param host_id [Fixnum]
    #
    # @return [Hash] host details
    def host_detail(scan_id, host_id)
      nessus_rest_get("scans/#{scan_id}/hosts/#{host_id}")
    end

    #
    # Return hash of plugin details for a specific host from a scan
    #
    # @param scan_id [Fixnum]
    # @param host_id [Fixnum]
    # @param plugin_id [Fixnum]
    #
    # @return [Hash] plugin details
    def host_plugin_detail(scan_id, host_id, plugin_id)
      nessus_rest_get("scans/#{scan_id}/hosts/#{host_id}/plugins/#{plugin_id}")
    end

  end
end

