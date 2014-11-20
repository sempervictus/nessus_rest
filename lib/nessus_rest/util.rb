
module NessusREST
  module Util

    #
    # Return a hash containing only keys which match valid_options
    #
    # @param opts [Hash] unfiltered options
    # @param valid_options [Array] list of valid keys
    #
    # @return [Hash] filtered options
    def validate_options(opts, valid_options)
      post_data = {}
      opts.keys.each do |key|
        valid_options.map do |opt|
          if opt.to_s.downcase.strip == key.to_s.downcase.strip
            post_data[key.intern] = opts[opt]
          end
        end
      end
      post_data
    end

  end
end
