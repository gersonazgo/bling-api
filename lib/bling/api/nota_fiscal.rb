#lib/bling/api/nota_fiscal.rb
require 'byebug'
require 'faraday'
require 'json'

module Bling
  module Api
    class NotaFiscal < Bling::Api::Base

      attr_reader :serie, :numero, :loja, :numeroPedidoLoja, :tipo, :situacao, :contato, :vendedor, :dataEmissao, :valorNota, :chaveAcesso, :codigosRastreamento
      
      def initialize(attributes)
        @serie = attributes["serie"]
        @numero = attributes["numero"]
        @loja = attributes["loja"]
        @numeroPedidoLoja = attributes["numeroPedidoLoja"]
        @tipo = attributes["tipo"]
        @situacao = attributes["situacao"]
        @contato = attributes["contato"]
        @vendedor = attributes["vendedor"]
        @dataEmissao = attributes["dataEmissao"]
        @valorNota = attributes["valorNota"]
        @chaveAcesso = attributes["chaveAcesso"]
        @codigosRastreamento = attributes["codigosRastreamento"]
      end

      def self.find(numero, serie)
        if serie.nil?
          super
        else
          super "#{numero}/#{serie}"
        end
      end

      def self.path
        "notasfiscais"
      end

      def self.object_type
        "notafiscal"
      end

      def self.set_filters attributes
        data_emissao_from = attributes[:data_emissao_from]
        data_emissao_to   = attributes[:data_emissao_to]
        situacao          = attributes[:situacao]
        filters           = ""

        if data_emissao_from && data_emissao_to
          filters << "dataEmissao[#{data_emissao_from.strftime("%d/%m/%Y")} TO #{data_emissao_to.strftime("%d/%m/%Y")}]"
        end

        filters << ";" if filters.match(/dataEmissao/) && situacao
        filters << "situacao[#{situacao}]" if situacao
        filters
      end

      # def self.raise_error_from_response(response, type=BlingError)
      #   super response, type
      # end

    end
  end
end