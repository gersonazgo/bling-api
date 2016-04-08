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
  transporte = FactoryGirl.build(:transporte, volumes: [volume])

  item = FactoryGirl.build(:item) 
  parcela = FactoryGirl.build(:parcela) 
  cliente = FactoryGirl.build(:cliente) 

  pedido = FactoryGirl.build(:pedido, transporte: transporte, itens:[item], parcelas: [parcela], cliente: cliente)
end