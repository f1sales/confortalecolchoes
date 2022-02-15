require 'ostruct'
require 'byebug'

RSpec.describe F1SalesCustom::Hooks::Lead do
  let(:customer) do
    customer = OpenStruct.new
    customer.name = 'Marcio'
    customer.phone = '1198788899'
    customer.email = 'marcio@f1sales.com.br'

    customer
  end

  let(:source) do
    source = OpenStruct.new
    source.name = 'Facebook - Confortale Colchões'

    source
  end

  let(:product) do
    product = OpenStruct.new
    product.name = product_name

    product
  end

  let(:lead) do
    lead = OpenStruct.new
    lead.source = source
    lead.customer = customer
    lead.product = product

    lead
  end


  context 'when product contains "Jabaquara"' do
    let(:product_name) { '[CV] [Jabaquara]' }

    it 'returns source name' do
      expect(described_class.switch_source(lead)).to eq('Facebook - Confortale Colchões - Jabaquara')
    end
  end

  context 'when product contains "Santo André"' do
    let(:product_name) { '[CV] Santo André' }

    it 'returns source name' do
      expect(described_class.switch_source(lead)).to eq('Facebook - Confortale Colchões - Santo André')
    end
  end

  context 'when product contains "Interlagos"' do
    let(:product_name) { '[CV] Interlagos' }

    it 'returns source name' do
      expect(described_class.switch_source(lead)).to eq('Facebook - Confortale Colchões - Interlagos')
    end
  end

  context 'when product contains "Jurubatuba"' do
    let(:product_name) { '[CV] Jurubatuba' }

    it 'returns source name' do
      expect(described_class.switch_source(lead)).to eq('Facebook - Confortale Colchões - Jurubatuba')
    end
  end
end
