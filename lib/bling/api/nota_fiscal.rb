#lib/bling/api/nota_fiscal.rb
require 'byebug'
require 'faraday'
require 'json'

module Bling
  module Api
    class NotaFiscal < Bling::Api::Base

      attr_reader :serie, :numero, :loja, :numeroPedidoLoja, :tipo, :situacao, :contato, :vendedor, :dataEmissao, :valorNota, :chaveAcesso, :codigosRastreamento, :xml, :transporte
      
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
        @xml = attributes["xml"]
        @linkDanfe = attributes["linkDanfe"]

        # Objects
        if attributes["codigosRastreamento"].is_a? Hash
          @codigosRastreamento = Bling::Api::NotasFiscais::CodigoRastreamento.new(attributes["codigosRastreamento"])
        else
          @codigosRastreamento = nil
        end
        
        unless attributes["transporte"].nil?
          @transporte = Bling::Api::NotasFiscais::Transporte.new(attributes["transporte"])
        else
          @transporte = nil 
        end
      end

      def self.find attributes
        if attributes[:serie].nil?
          super
        else
          super "#{attributes[:numero]}/#{attributes[:serie]}"
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

    end
  end
end