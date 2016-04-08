# Bling API

Oi! Essa gem foi criada pra resolver os problemas de integração Bling (www.bling.com.br)
com apps em Ruby on Rails.


## Instalação

Adicione esta linha no Gemfile do seu app:

```ruby
gem 'bling-api', :git => 'git://github.com/tanoku/redcarpet.git'
```

Então execute:

    $ bundle

## Instruções de uso

### Nota Fiscal

Você pode buscar uma nota específica através do comando `Bling::Api::NotaFiscal.find` ou listar todas com `Bling::Api::NotaFiscal.all`. A inserção de Nota Fiscal se dá através do pedido e, portanto, não possuímos um método .save.

```ruby
# Busca uma nota fiscal através de seu número e série
nota_fiscal = Bling::Api::NotaFiscal.find(numero: 1, serie: 1)

# Busca todas as notas fiscais
notas_fiscais = Bling::Api::NotaFiscal.all

# Busca notas fiscais com filtros e paginação 
# Situações possíveis 
# 1 - Pendente
# 2 - Emitida
# 3 - Cancelada
# 4 - Enviada - Aguardando recibo
# 5 - Rejeitada
# 6 - Autorizada
# 7 - Emitida DANFE
# 8 - Registrada
# 9 - Enviada - Aguardando protocolo
# 10 - Denegada
notas_fiscais = Bling::Api::NotaFiscal.all(data_emissao_from: Date.new(2016,4,4), data_emissao_to: Date.new(2016,4,4), situacao: 1, page: 1)

# Inserir uma nova nota fiscal se dá apenas através do pedido.
```