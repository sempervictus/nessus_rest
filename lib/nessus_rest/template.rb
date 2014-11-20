
module NessusREST

  module Template

    def type_check(type, &block)
      if ['scan','policy'].any? {|t| t == type}
        block.call
      else
        raise "Only scan and policy template types are accepted"
      end
    end

    def list_templates(type = 'scan')
      type_check(type) { nessus_rest_get("editor/#{type}/templates") }
    end

    def template_get(template_id, type = 'scan')
      type_check(type) { nessus_rest_get("editor/#{type}/templates/#{template_id}") }
    end

    def template_edit(template_id, settings = {}, type = 'scan')
      type_check(type) { nessus_rest_get("editor/#{type}/#{template_id}") }
    end

  end
end
