require 'spec_helper'

describe Bling::Api::Pedido do
  before :each do 
    Bling::Api.apikey = ENV['BLING_API_KEY']
  end

  describe "find" do 
    it "returns a valid Pedido when it exists" do
      VCR.use_cassette('valid_pedido') do
        pedido = Bling::Api::Pedido.find(numero: 2)
        expect(Bling::Api::Pedido).to eq(pedido.class)

        # Check that the fields are accessible by our model
        expect(pedido.desconto).to eq(0.to_s)
        expect(pedido.observacoes).to eq("")
        expect(pedido.observacaointerna).to eq("")
        expect(pedido.data).to eq("2016-04-08")
        expect(pedido.numero).to eq("2")
        expect(pedido.vendedor).to eq("")
        expect(pedido.valorfrete).to eq("0.00")
        expect(pedido.totalprodutos).to eq("49.90")
        expect(pedido.totalvenda).to eq("49.90")
        expect(pedido.situacao).to eq("Atendido")
        expect(pedido.numeroPedidoLoja).to eq(nil)
        expect(pedido.dataPrevista).to eq(nil)

        # Check Cliente fields
        cliente = pedido.cliente
        
        expect(cliente.nome).to eq("GERSON AZEVEDO GOMES")
        expect(cliente.cnpj).to eq("018.400.050-50")
        expect(cliente.ie).to eq("")
        expect(cliente.endereco).to eq("Rua Vicente da Fontoura")
        expect(cliente.numero).to eq("1021")
        expect(cliente.complemento).to eq("302")
        expect(cliente.cidade).to eq("Porto Alegre")
        expect(cliente.bairro).to eq("SANTANA")
        expect(cliente.cep).to eq("90.640-001")
        expect(cliente.uf).to eq("RS")
        expect(cliente.email).to eq("")

        # Check Item fields
        item = pedido.itens.first
        
        expect(item.codigo).to eq("PJ002CR")
        expect(item.descricao).to eq("Porta-Jaleco Doodle")
        expect(item.quantidade).to eq("1.0000")
        expect(item.valorunidade).to eq("49.9000000000")
        expect(item.precocusto).to eq("0.0000000000")
        expect(item.descontoItem).to eq("0.00")
        expect(item.un).to eq("UN")

        # Check Parcela fields
        parcela = pedido.parcelas.first
        
        expect(parcela.valor).to eq("16.64")
        expect(parcela.dataVencimento).to eq("2016-05-08 00:00:00")
        expect(parcela.obs).to eq("")

         # Check Nota fields
        nota = pedido.nota
        
        expect(nota.serie).to eq("1")
        expect(nota.numero).to eq("000005")
        expect(nota.dataEmissao).to eq("2016-04-08 00:00:00")
        expect(nota.situacao).to eq("1")
        expect(nota.chaveAcesso).to eq(nil)

        # Check Transporte fields
        transporte = pedido.transporte
        expect(transporte.class).to eq(Bling::Api::Transporte)

        expect(transporte.transportadora).to eq(nil)
        expect(transporte.servico_correios).to eq("PAC")

        # Check Volume fields
        volume = transporte.volumes.first
        expect(volume.class).to eq(Bling::Api::Transportes::Volume)

        expect(volume.idServico).to eq("512679065")
        expect(volume.servico).to eq("PAC")
        expect(volume.codigoRastreamento).to eq("PJ644450177BR")
        expect(volume.valorFretePrevisto).to eq("8.00")
        expect(volume.dataSaida).to eq("2016-04-08")
        expect(volume.prazoEntregaPrevisto).to eq("5")

        # Check CodigoRastreamento fields
        codigosRastreamento = pedido.codigosRastreamento
        expect(codigosRastreamento.class).to eq(Bling::Api::CodigoRastreamento)
        
        expect(codigosRastreamento.codigoRastreamento).to eq("PJ644450177BR")
      end
    end

     it "returns an error when it doesn't exist" do
      VCR.use_cassette('invalid_nota_pedido') do
        expect { Bling::Api::Pedido.find(numero: 1123421) }.to raise_error Bling::Api::BlingResourceNotFound
      end
    end

  end

  describe "all" do 
    it "returns a valid list of Pedido" do
      VCR.use_cassette('pedido_list') do
        result = Bling::Api::Pedido.all
        expect(result.length).to eq(2)
        expect(result.class).to eq(Array)
        expect(result.first.class).to eq(Bling::Api::Pedido)
      end
    end

    # it "returns a valid list of NotaFiscal with filters" do
    #   VCR.use_cassette('nota_fiscal_list_with_filters') do
    #     result = Bling::Api::NotaFiscal.all(data_emissao_from: Date.new(2016,4,4), data_emissao_to: Date.new(2016,4,4), situacao: 1, page: 1)

    #     expect(result.length).to eq(1)
    #     expect(result.class).to eq(Array)
    #     expect(result.first.class).to eq(Bling::Api::NotaFiscal)
    #   end
    # end

    # it "returns an empty list of NotaFiscal" do
    #   VCR.use_cassette('empty_nota_fiscal_list') do
    #     result = Bling::Api::NotaFiscal.all(data_emissao_from: Date.new(2015,4,4), data_emissao_to: Date.new(2015,4,4))
    #     expect(result.length).to eq(0)
    #     expect(result.class).to eq(Array)
    #   end
    # end

    # it "returns an error with invalid page" do
    #   VCR.use_cassette('nota_fiscal_list_with_an_invalid_page') do
    #     expect { Bling::Api::NotaFiscal.all(page: 2, data_emissao_from: Date.new(2016,4,4), data_emissao_to: Date.new(2016,4,4)) }.to raise_error Bling::Api::BlingResourceNotFound
    #   end
    # end
  end


end