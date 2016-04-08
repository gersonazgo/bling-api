#lib/bling/api/nota_fiscal.rb
require 'byebug'
require 'faraday'
require 'json'

module Bling
  module Api
    module Pedidos
      class Cliente

        attr_accessor :nome, :cnpj, :ie, :endereco, :numero, :complemento, :cidade, :bairro, :cep, :uf, :email, :tipoPessoa, :fone, :contribuinte     
           
        def initialize(attributes={})
          @nome = attributes["nome"]
          @cnpj = attributes["cnpj"]
          @ie = attributes["ie"]
          @endereco = attributes["endereco"]
          @numero = attributes["numero"]
          @complemento = attributes["complemento"]
          @cidade = attributes["cidade"]
          @bairro = attributes["bairro"]
          @cep = attributes["cep"]
          @uf = attributes["uf"]
          @fone = attributes["fone"]
          @email = attributes["email"]
          @tipoPessoa = attributes["tipoPessoa"] || "F"
          @contribuinte = attributes["contribuinte"] || "9"
        end
      end
    end
  end
end