#lib/bling/api/nota_fiscal.rb
require 'byebug'
require 'faraday'
require 'json'

module Bling
  module Api
    module Pedidos
      class Item

        attr_accessor :codigo, :descricao, :quantidade, :valorunidade, :precocusto, :descontoItem, :un
        
        def initialize(attributes={})
          @codigo = attributes["codigo"]
          @descricao = attributes["descricao"]
          @quantidade = attributes["quantidade"]
          @valorunidade = attributes["valorunidade"]
          @precocusto = attributes["precocusto"]
          @descontoItem = attributes["descontoItem"]
          @un = attributes["un"]
        end

      end
    end
  end
end