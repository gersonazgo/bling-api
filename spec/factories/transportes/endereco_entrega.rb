FactoryGirl.define do
  factory :endereco_entrega, class: Bling::Api::Transportes::EnderecoEntrega do
    nome "Juliana Gomes"
    endereco "Rua Olívio Dutra, 24"
    numero ""
    complemento ""
    cidade "Porto Alegre"
    bairro ""
    cep "90640001"
    uf "RS"
  end
end

