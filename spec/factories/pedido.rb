FactoryGirl.define do
  factory :pedido, class: Bling::Api::Pedido do
    desconto "0"
    observacoes ""
    observacaointerna ""
    data Date.new(2016,4,13)
    numero "2"
    vendedor ""
    valorfrete "10.00"
    totalprodutos "49.90"
    totalvenda "49.90"
    situacao "Atendido"
    numeroPedidoLoja nil
    dataPrevista nil
  end
end