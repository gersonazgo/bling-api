FactoryGirl.define do
  factory :transporte, class: Bling::Api::Transporte do
    transportadora "Correios"
    tipo_frete "R"
    # servico_correios "PAC"
    servico_correios "SEDEX (CONTRATO)"
  end
end

