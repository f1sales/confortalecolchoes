# frozen_string_literal: true

require_relative "confortalecolchoes/version"
require "f1sales_custom/hooks"

module Confortalecolchoes
  class Error < StandardError; end

  class F1SalesCustom::Hooks::Lead
    def self.switch_source(lead)
      source_name = lead.source ? lead.source.name : ''
      product_name = lead.product.name.downcase

      if product_name.include?('santo andré')
        "#{source_name} - Santo André"
      elsif product_name.include?('interlagos')
        "#{source_name} - Interlagos"
      elsif product_name.include?('jabaquara')
        "#{source_name} - Jabaquara"
      elsif product_name.include?('jurubatuba')
        "#{source_name} - Jurubatuba"
      else
        lead.source.name
      end
    end
  end
end
