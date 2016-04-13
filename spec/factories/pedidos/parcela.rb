FactoryGirl.define do
  factory :parcela, class: Bling::Api::Pedidos::Parcela do
    valor "16.64"
    dataVencimento Date.today
    obs ""
  end
end