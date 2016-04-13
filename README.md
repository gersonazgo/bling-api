# Bling API

A gem ideal para quem quer enviar Notas Fiscais e Pedidos da sua loja/app diretamente para o Bling (www.bling.com.br)


## Instalação

Adicione esta linha no Gemfile do seu app:

```ruby
gem 'bling-api', :git => 'https://github.com/gersonazgo/bling-api.git'
```

Então execute:

    $ bundle

## Instruções de uso

Configure as suas credenciais de acesso ao Bling em `initializers/bling.rb`

```ruby
Bling::Api.apikey = ENV['BLING_API_KEY']
```

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
notas_fiscais = Bling::Api::NotaFiscal.all(data_emissao_from: Date.new(2016,4,4), 
data_emissao_to: Date.new(2016,4,4), situacao: 1, page: 1)

# Inserir uma nova nota fiscal se dá apenas através do pedido.
```

### Pedido

Você pode buscar um pedido específico através do comando `Bling::Api::Pedido.find` ou listar todos com `Bling::Api::Pedido.all`. 

```ruby
# Busca um pedido através de seu número
pedido = Bling::Api::Pedido.find(numero: 1)

# Busca todos os pedidos
notas_fiscais = Bling::Api::Pedido.all

# Busca pedidos com filtros e paginação 
# Situações possíveis 
# 0 - Em Aberto
# 1 - Atendido
# 2 - Cancelado
# 3 - Em andamento
# 4 - Venda Agenciada
# 10 - Em digitação
# 11 - Verificado
pedidos = Bling::Api::NotaFiscal.all(data_emissao_from: Date.new(2016,4,4), 
data_emissao_to: Date.new(2016,4,4), situacao: 1, page: 1)

# Salva um pedido no Bling.
Pedido.save
```
## Agradecimentos
Agradecemos aos criadores das gems https://github.com/organisys/bling-ruby e https://github.com/arielschvartz/Bling-Rails que usamos como referência. Thanks, guys!

## Colaboradores
A equipe do Porta-Jaleco (www.portajaleco.com.br) é responsável pela manutenção desta Gem.

Gerson Azevedo <gersonazgo@gmail.com>
Aline Ebone <ini.ebone@gmail.com>
