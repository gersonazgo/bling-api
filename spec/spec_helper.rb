$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'bling/api'
require 'webmock/rspec'
require 'vcr'
require 'awesome_print'
require 'factory_girl'

VCR.configure do |c|
  c.cassette_library_dir = "spec/fixtures"
  c.hook_into :webmock
end

RSpec.configure do |config|
  FactoryGirl.find_definitions
  config.include FactoryGirl::Syntax::Methods
end

def create_pedido
  volume = FactoryGirl.build(:volume)
  endereco_entrega = FactoryGirl.build(:endereco_entrega)
  transporte = FactoryGirl.build(:transporte, volumes: [volume], enderecoEntrega: endereco_entrega)

  item = FactoryGirl.build(:item)
  item_2 = FactoryGirl.build(:item, codigo: "PJ006CR", descricao: "Porta-Jaleco Flamingo") 
  parcela = FactoryGirl.build(:parcela) 
  cliente = FactoryGirl.build(:cliente) 

  pedido = FactoryGirl.build(:pedido, transporte: transporte, itens:[item, item_2], parcelas: [parcela], cliente: cliente)
end