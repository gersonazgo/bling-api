FactoryGirl.define do
  factory :volume, class: Bling::Api::Transportes::Volume do
    idServico "512679065"
    servico "PAC"
    codigoRastreamento "PJ644450177BR"
    valorFretePrevisto "8.00"
    dataSaida "2016-04-08"
    prazoEntregaPrevisto "5"
  end
end

