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
    source.name = source_name

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

  let(:source_name) { 'Facebook - Confortale Colchões' }

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

  context 'when came from simmons' do
    let(:product_name) { '*Exclusivas I Titanium/22 I 31/03/2022' }

    before { lead.message = message }

    context 'when message contains "avenida jabaquara 938"' do
      let(:source_name) { 'Simmons - Facebook' }
      let(:message) { 'conditional_question_2: São Paulo; conditional_question_3: confortale-avenida jabaquara 938; conditional_question_1: São Paulo' }

      it 'returns source name' do
        expect(described_class.switch_source(lead)).to eq('Simmons - Facebook - Jabaquara')
      end
    end

    context 'when message contains "avenida portugal 1841"' do
      let(:source_name) { 'Simmons - Widgrid' }
      let(:message) { 'Simmons - ESC - confortale-avenida portugal 1841' }

      it 'returns source name' do
        expect(described_class.switch_source(lead)).to eq('Simmons - Widgrid - Santo André')
      end
    end

    context 'when message contains "avenida cruzeiro do sul 1100"' do
      let(:source_name) { 'Simmons - Facebook' }
      let(:message) { 'conditional_question_1: São Paulo; conditional_question_2: São Paulo; conditional_question_3: confortale-avenida cruzeiro do sul 1100' }

      it 'returns source name' do
        expect(described_class.switch_source(lead)).to eq('Simmons - Facebook - Interlagos')
      end
    end

    context 'when message contains "rua jurubatuba 707"' do
      let(:source_name) { 'Simmons - Facebook' }
      let(:message) { 'conditional_question_1: São Paulo; conditional_question_2: São Bernardo do Campo; conditional_question_3: confortale-rua jurubatuba 707' }

      it 'returns source name' do
        expect(described_class.switch_source(lead)).to eq('Simmons - Facebook - Jurubatuba')
      end
    end
  end
end
