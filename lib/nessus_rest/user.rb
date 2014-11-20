
module NessusREST

  module User

    VALID_FIELDS = %w{id username name email permissions lastlogin type}
    PERMISSIONS = {
      :read_only            => 16,
      :standard             => 32,
      :administrator        => 64,
      :system_administrator => 128
    }

    include Util

    def validate_options(opts, valid_options = VALID_FIELDS)
      super(opts,valid_options)
    end

    def list_users
      nessus_rest_get('users')['users']
    end

    def user_get(user_id)
      nessus_rest_get("users/#{user_id}")
    end

    def user_update(user_id, permissions = PERMISSIONS[:standard], settings = {})
      post_data = {:user_id => user_id, :permissions => permissions}
      nessus_rest_post("users/#{user_id}", post_data.merge(validate_options(settings)))
    end

    def user_create(username, password, type = 'local', permissions = PERMISSIONS[:standard], settings = {})
      post_data = {
        :username => username,
        :password => password,
        :type => type,
        :permissions => permissions
      }
      nessus_rest_post("users", post_data.merge(validate_options(settings)))
    end

    def user_chpasswd(user_id, password)
      post_data = {:user_id => user_id, :password => password} 
      nessus_rest_post("users/#{user_id}/chpasswd", post_data)
    end

    def user_delete(user_id)
      nessus_rest_delete("users/#{user_id}")
    end

  end
end

