FactoryGirl.define do
  factory :transporte, class: Bling::Api::Transporte do
    transportadora nil
    tipo_frete "R"
    servico_correios "SEDEX (CONTRATO)"
  end
end

