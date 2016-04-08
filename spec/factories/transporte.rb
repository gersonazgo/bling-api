FactoryGirl.define do
  factory :transporte, class: Bling::Api::Transporte do
    transportadora nil
    servico_correios "SEDEX (CONTRATO)"
  end
end

