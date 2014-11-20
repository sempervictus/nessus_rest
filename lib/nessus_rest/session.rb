
module NessusREST
  module Session

    DEBUG = 1
    IDMIN = 10000
    IDMAX = 99999

    
    #
    # Return a valid session token (session_create)
    #
    # @param user [String] username
    # @param password [String] password
    # @param sid [Fixnum] session ID
    #
    # @return String token
    def login(user, password, sid = nil)
      sid   ||= IDMIN + rand(IDMAX-IDMIN)
      @nurl ||= "https://localhost:8834/"
      post  = { "username" => user, "password" => password, 'seq' => sid }

      response_json = nessus_request('session', post)

      if response_json['token']
        @token = response_json['token']
        @name = user
        @seqid = sid
        # Compatibility with XMLRPC ivar
        user_permissions = nessus_request('session', auth_header, :get)['permissions']
        @admin = ([64,128].any? {|perm| perm == user_permissions}).to_s.upcase
        return @token
      else
        raise "Cannot authenticate to #{@nurl} as #{user} with #{password} due to #{response_json['error']}"
      end

    end

    #
    # Logout of current session
    #
    # @return [Hash] freed auth header
    def logout
      session_delete
      @token = ''
      @seqid = 0
      auth_header
    end

    #
    # Return auth header params hash
    #
    # @return [Hash] authentication header
    def auth_header
      { :token => @token, :seq => @seqid }
    end

    #
    # Return response for API request (wrappers)
    #
    # @params uri [String] API uri
    # @params post_data [Hash] data to be sent in API request
    #
    # @return [Hash] API response
    %w{get post put delete}.each do |meth|
      define_method("nessus_rest_#{meth}") do |uri, post_data = {}|
        nessus_request(uri, post_data, meth.intern)
      end
    end

    #
    # Return response for API request
    #
    # @params uri [String] API uri
    # @params post_data [Hash] data to be sent in API request
    # @params verb [Symbol] HTTP method to use
    #
    # @return [Hash] API response/Error message
    def nessus_request(uri, post_data = {}, verb = :post)
      if @seqid and @seqid > 10000 and @token and !@token.empty?
        post_data.merge!(auth_header)
      end

      begin
        nes_resp =  ::Nestful.send( verb.intern, @nurl + uri, post_data )
        if nes_resp.body.nil? or nes_resp.body.empty? or nes_resp.body == 'null'
          response = nes_resp.headers.to_hash
        elsif nes_resp.respond_to?(:keys)
          response = nes_resp.to_hash
        else
          response = nes_resp.to_a
        end
      rescue Nestful::ConnectionError, Nestful::ClientError => e

        response = JSON.parse(e.response.body).merge(
          'status_code' => e.response.code,
          'message' => e.response.message
        )

        if DEBUG > 0
          response.merge!(
            'post_data' => post_data,
            'uri' => uri
          )
        end

      end
      response
    end

    #
    # Get current session information
    #
    # @return [Hash] session data
    def session_get
      nessus_rest_get("session")
    end

    #
    # Update session details
    #
    # @param name [String] new session name
    # @param email [String] new email address
    #
    # @return [Hash] session data
    def session_update(name = @name, email = nil)
      post_data = {:name => name}
      post_data.merge!(:email => email) if email
      nessus_rest_put('session', post_data)
    end

    #
    # Delete session (logout)
    #
    # @return [Hash] session headers
    def session_delete
      nessus_rest_delete('session')
    end

    #
    # TODO: this seems to provoke a 403, regardless of user privilege
    #
    def session_chpasswd(password)
      nessus_rest_put('session/chpasswd', {:password => password})
    end
  end
end

