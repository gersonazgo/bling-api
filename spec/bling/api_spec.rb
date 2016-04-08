require 'spec_helper'

describe Bling::Api do
  it 'has a version number' do
    expect(Bling::Api::VERSION).not_to be nil
  end

  it 'has a Base Class' do
    expect(Bling::Api::Base).not_to be nil
  end

  it 'has a NotaFiscal Class' do
    expect(Bling::Api::NotaFiscal).not_to be nil
  end

  it 'has a CodigoRastreamento Class' do
    expect(Bling::Api::CodigoRastreamento).not_to be nil
  end

  it 'has a Transporte Class' do
    expect(Bling::Api::Transporte).not_to be nil
  end

  it 'has a Transportes::EnderecoEntrega Class' do
    expect(Bling::Api::Transportes::EnderecoEntrega).not_to be nil
  end

  it 'has a Transportes::Volume Class' do
    expect(Bling::Api::Transportes::Volume).not_to be nil
  end
end
