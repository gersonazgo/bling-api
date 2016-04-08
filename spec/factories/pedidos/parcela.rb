FactoryGirl.define do
  factory :parcela, class: Bling::Api::Pedidos::Parcela do
    valor "16.64"
    dataVencimento "2016-05-08 00:00:00"
    obs ""
  end
end