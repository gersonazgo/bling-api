#lib/bling/api/pedido.rb
require 'byebug'
require 'faraday'
require 'json'

module Bling
  module Api
    class Pedido < Bling::Api::Base

      attr_accessor :desconto, :observacoes, :observacaointerna, :data, :numeroPedidoLoja, :numero, :situacao, :valorfrete, :vendedor, :totalprodutos, :totalvenda, :dataPrevista, :tipoIntegracao, :cliente, :itens, :parcelas, :nota, :transporte, :codigosRastreamento, :loja, :nat_operacao
      
      def initialize(attributes={})
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
        @loja = attributes["loja"] || "9"
        @nat_operacao = attributes["nat_operacao"] || "Venda de Mercadorias"

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

      def path
        "pedidos"
      end

      def object_type
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

      def to_xml

        if self.transporte.enderecoEntrega.nil? 
          enderecoEntrega = self.cliente 
        else
          enderecoEntrega = self.transporte.enderecoEntrega
        end

        pedido = {
          "pedido": {
            "numero": self.numero,
            "numero_loja": self.numeroPedidoLoja,
            "loja": self.loja,
            "nat_operacao": self.nat_operacao,
            "vlr_frete": self.valorfrete,
            "vlr_desconto": self.desconto,
            "obs": self.observacoes,
            "obs_internas": self.observacaointerna,
            "cliente":{
              "nome": self.cliente.nome,
              "tipoPessoa": self.cliente.tipoPessoa,
              "cpf_cnpj": self.cliente.cnpj,
              "ie": self.cliente.ie,
              "ie_rg": self.cliente.ie,
              "contribuinte": self.cliente.contribuinte,
              "endereco": self.cliente.endereco,
              "numero": self.cliente.numero,
              "complemento": self.cliente.complemento,
              "bairro": self.cliente.bairro,
              "cep": self.cliente.cep,
              "cidade": self.cliente.cidade,
              "uf": self.cliente.uf,
              "fone": self.cliente.fone,
              "email": self.cliente.email
            },
            "transporte":{
              "transportadora": self.transporte.transportadora,
              "tipo_frete": self.transporte.tipo_frete,
              "servico_correios": self.transporte.servico_correios,
              "peso_bruto": self.transporte.peso_bruto,
              "dados_etiqueta":{
                "nome": enderecoEntrega.nome,
                "endereco": enderecoEntrega.endereco,
                "numero": enderecoEntrega.numero,
                "complemento": enderecoEntrega.complemento,
                "municipio": enderecoEntrega.cidade,
                "uf": enderecoEntrega.uf,
                "cep": enderecoEntrega.cep,
                "bairro": enderecoEntrega.bairro
              }
            }
          }
        }

        pedido[:pedido][:itens] = []
        self.itens.each do |item|
          item = { 
            "item": {
              "codigo": item.codigo, 
              "descricao": item.descricao, 
              "un": item.un, 
              "qtde": item.quantidade, 
              "vlr_unit": item.valorunidade
            }
          }
          pedido[:pedido][:itens] << item
        end

        pedido[:pedido][:parcelas] = []
        self.parcelas.each do |parcela|
          parcela = { 
            "parcela": {
              "dias": parcela.dias, 
              "data": parcela.dataVencimento, 
              "vlr": parcela.valor, 
              "obs": parcela.obs, 
            }
          }
          pedido[:pedido][:parcelas] << parcela
        end

        pedido.to_xml
      end

    end
  end
end