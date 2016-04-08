FactoryGirl.define do
  factory :item, class: Bling::Api::Pedidos::Item do
    codigo "PJ002CR"
    descricao "Porta-Jaleco Doodle"
    quantidade "1.0000"
    valorunidade "49.9000000000"
    precocusto "0.0000000000"
    descontoItem "0.00"
    un "UN"
  end
end