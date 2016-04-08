require 'spec_helper'

describe Bling::Api::NotaFiscal do
  describe "find" do 
    it "returns a valid NotaFiscal when it exists" do
      VCR.use_cassette('valid_nota_fiscal') do
        numero = 4
        serie = 1
        nota_fiscal = Bling::Api::NotaFiscal.find(numero, serie)
        expect(Bling::Api::NotaFiscal).to eq(nota_fiscal.class)

        # Check that the fields are accessible by our model
        expect(nota_fiscal.serie).to eq("1")
        expect(nota_fiscal.numero).to eq("000004")
        expect(nota_fiscal.loja).to eq("0")
        expect(nota_fiscal.numeroPedidoLoja).to eq(nil)
        expect(nota_fiscal.tipo).to eq("S")
        expect(nota_fiscal.situacao).to eq("Pendente")
        expect(nota_fiscal.contato).to eq("GERSON AZEVEDO GOMES")
        expect(nota_fiscal.vendedor).to eq("")
        expect(nota_fiscal.dataEmissao).to eq("2016-04-07 00:00:00")
        expect(nota_fiscal.valorNota).to eq("49.90")
        expect(nota_fiscal.chaveAcesso).to eq(nil)
        expect(nota_fiscal.codigosRastreamento.codigoRastreamento).to eq("DW111802513BR")

        # Check transporte fields
        transporte = nota_fiscal.transporte
        expect(transporte.class).to eq(Bling::Api::NotasFiscais::Transporte)

        expect(transporte.transportadora).to eq(nil)
        expect(transporte.servico_correios).to eq("SEDEX (CONTRATO)")

        # Check volume fields
        volume = transporte.volumes.first
        expect(volume.class).to eq(Bling::Api::NotasFiscais::Transportes::Volume)

        expect(volume.idServico).to eq("512679064")
        expect(volume.servico).to eq("SEDEX (CONTRATO)")
        expect(volume.codigoRastreamento).to eq("DW111802513BR")
        expect(volume.valorFretePrevisto).to eq("13.65")
        expect(volume.dataSaida).to eq("2016-04-07")
        expect(volume.prazoEntregaPrevisto).to eq("1")
      end
    end

    it "returns an error when it doesn't exist" do
      VCR.use_cassette('invalid_nota_fiscal') do
        numero = 1123
        serie = 2442
        expect { Bling::Api::NotaFiscal.find(numero, serie) }.to raise_error Bling::Api::BlingResourceNotFound
      end
    end
  end

  describe "all" do 
    it "returns a valid list of NotaFiscal" do
      VCR.use_cassette('nota_fiscal_list') do
        result = Bling::Api::NotaFiscal.all
        expect(result.length).to eq(4)
        expect(result.class).to eq(Array)
        expect(result.first.class).to eq(Bling::Api::NotaFiscal)
      end
    end

    it "returns a valid list of NotaFiscal with filters" do
      VCR.use_cassette('nota_fiscal_list_with_filters') do
        result = Bling::Api::NotaFiscal.all(data_emissao_from: Date.new(2016,4,4), data_emissao_to: Date.new(2016,4,4), situacao: 1, page: 1)

        expect(result.length).to eq(1)
        expect(result.class).to eq(Array)
        expect(result.first.class).to eq(Bling::Api::NotaFiscal)
      end
    end

    it "returns an empty list of NotaFiscal" do
      VCR.use_cassette('empty_nota_fiscal_list') do
        result = Bling::Api::NotaFiscal.all(data_emissao_from: Date.new(2015,4,4), data_emissao_to: Date.new(2015,4,4))
        expect(result.length).to eq(0)
        expect(result.class).to eq(Array)
      end
    end

    it "returns an error with invalid page" do
      VCR.use_cassette('nota_fiscal_list_with_an_invalid_page') do
        expect { Bling::Api::NotaFiscal.all(page: 2, data_emissao_from: Date.new(2016,4,4), data_emissao_to: Date.new(2016,4,4)) }.to raise_error Bling::Api::BlingResourceNotFound
      end
    end
  end
end