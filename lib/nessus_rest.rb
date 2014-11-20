require 'nestful'

module NessusREST
end

require 'nessus_rest/version'
require 'nessus_rest/util'
require 'nessus_rest/session'
require 'nessus_rest/scan'
require 'nessus_rest/policy'
require 'nessus_rest/user'
require 'nessus_rest/group'
require 'nessus_rest/template'
require 'nessus_rest/folder'
require 'nessus_rest/server'
require 'nessus_rest/scanner'
require 'nessus_rest/file'
require 'nessus_rest/permission'
require 'nessus_rest/plugin_rule'
require 'nessus_rest/cisco_ise'


module NessusREST

  class Client
    include Session
    include Scan
    include Policy
    include User
    include Group
    include Template
    include Folder
    include Server
    include Scanner
    include File
    include Permission
    include PluginRule

    attr_reader :token, :seq_id
    
    def initialize(url,user,password)
      if url.match(/^\s*$/)
        @nurl="https://localhost:8834/"
      else
        if url =~ /\/$/
          @nurl=url
        else
          @nurl=url + "/"
        end
      end
      @token=''
      login(user,password)
    end

  end

end
