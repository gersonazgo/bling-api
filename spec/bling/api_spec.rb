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
end
