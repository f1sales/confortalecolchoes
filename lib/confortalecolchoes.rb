# frozen_string_literal: true

require_relative "confortalecolchoes/version"
require "f1sales_custom/hooks"

module Confortalecolchoes
  class Error < StandardError; end

  class F1SalesCustom::Hooks::Lead
    def self.switch_source(lead)
      source_name = lead.source ? lead.source.name : ''
      product_name = lead.product.name.downcase
      message = lead.message || ''

      if product_name.include?('santo andré') || message.include?('avenida portugal 1841')
        "#{source_name} - Santo André"
      elsif product_name.include?('interlagos') || message.include?('avenida cruzeiro do sul 1100')
        "#{source_name} - Interlagos"
      elsif product_name.include?('jabaquara') || message.include?('avenida jabaquara 938')
        "#{source_name} - Jabaquara"
      elsif product_name.include?('jurubatuba') || message.include?('rua jurubatuba 707')
        "#{source_name} - Jurubatuba"
      else
        lead.source.name
      end
    end
  end
end
