FactoryGirl.define do
  factory :cliente, class: Bling::Api::Pedidos::Cliente do
    nome "TESTE GOMES"
    cnpj "018.400.050-50"
    ie ""
    endereco "Rua Vicente da Fontoura"
    numero "1021"
    complemento "302"
    cidade "Porto Alegre"
    bairro "SANTANA"
    cep "90.640-001"
    uf "RS"
    email ""
  end
end