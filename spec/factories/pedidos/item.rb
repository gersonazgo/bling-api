FactoryGirl.define do
  factory :item, class: Bling::Api::Pedidos::Item do
    codigo "PJ002CR"
    descricao "Porta-Jaleco Doodle"
    quantidade "1"
    valorunidade "49.90"
    precocusto ""
    descontoItem ""
    un "UN"
  end
end