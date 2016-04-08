#lib/bling/api/pedido.rb
require 'byebug'
require 'faraday'
require 'json'

module Bling
  module Api
    class Pedido < Bling::Api::Base

      attr_reader :desconto, :observacoes, :observacaointerna, :data, :numeroPedidoLoja, :numero, :situacao, :valorfrete, :vendedor, :totalprodutos, :totalvenda, :dataPrevista, :tipoIntegracao, :cliente, :itens, :parcelas, :nota, :transporte, :codigosRastreamento
      
      def initialize(attributes)
        @desconto = attributes["desconto"]
        @observacoes = attributes["observacoes"]
        @observacaointerna = attributes["observacaointerna"]
        @data = attributes["data"]
        @numeroPedidoLoja = attributes["numeroPedidoLoja"]
        @numero = attributes["numero"]
        @situacao = attributes["situacao"]
        @valorfrete = attributes["valorfrete"]
        @vendedor = attributes["vendedor"]
        @totalprodutos = attributes["totalprodutos"]
        @totalvenda = attributes["totalvenda"]
        @dataPrevista = attributes["dataPrevista"]
        @tipoIntegracao = attributes["tipoIntegracao"]

        # Objects
        if attributes["cliente"].is_a? Hash
          @cliente = Bling::Api::Pedidos::Cliente.new(attributes["cliente"])
        else
          @cliente = nil
        end

        if attributes["itens"].is_a? Array
          @itens = []
          attributes["itens"].each do |item|
            @itens << Bling::Api::Pedidos::Item.new(item["item"])
          end
        else
          @itens = nil
        end

        if attributes["parcelas"].is_a? Array
          @parcelas = []
          attributes["parcelas"].each do |parcela|
            @parcelas << Bling::Api::Pedidos::Parcela.new(parcela["parcela"])
          end
        else
          @parcelas = nil
        end
        
        unless attributes["nota"].nil?
          @nota = Bling::Api::NotaFiscal.new(attributes["nota"])
        else
          @nota = nil 
        end

        unless attributes["transporte"].nil?
          @transporte = Bling::Api::Transporte.new(attributes["transporte"])
        else
          @transporte = nil 
        end

        if attributes["codigosRastreamento"].is_a? Hash
          @codigosRastreamento = Bling::Api::CodigoRastreamento.new(attributes["codigosRastreamento"])
        else
          @codigosRastreamento = nil
        end
      end

      def self.find attributes
        if attributes[:numero].nil?
          super
        else
          super "#{attributes[:numero]}"
        end
      end

      def self.path
        "pedidos"
      end

      def self.object_type
        "pedido"
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