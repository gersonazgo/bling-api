require "bling/api/base"
require "bling/api/exceptions"
require "bling/api/nota_fiscal"
require "bling/api/version"
require "bling/api/notas_fiscais/codigo_rastreamento"
require "bling/api/notas_fiscais/transporte"
require "bling/api/notas_fiscais/transportes/endereco_entrega"
require "bling/api/notas_fiscais/transportes/volume"



API_URL = "https://bling.com.br/Api/v2/"

module Bling
  module Api
    
    def self.api_url path
      File.join path, "/json/"
    end

    def self.get path, filters=""
      conn = Faraday.new(API_URL)

      conn.get do |req|                           
        req.url "#{api_url(path)}", apikey: ENV['BLING_API_KEY']
        req.params['filters'] = filters
      end
    end


    def self.post path, resource

      conn = Faraday.new(API_URL)

      conn.post do |req|                           
        req.url "#{api_url(path)}", apikey: ENV['BLING_API_KEY']
        req.params['xml'] = resource.to_xml
      end

      # unless body.is_a? Hash
      #   body = {}
      # end

      # xml = nil
      # if body['pedido']
      #   xml = body['pedido'].to_xml(root: 'pedido', dasherize: false).gsub('iten>', 'item>')
      # elsif body['produto']
      #   xml = body['produto'].to_xml(root: 'produto', dasherize: false)
      # elsif body['']
      # end

      # options = {
      #   query: {
      #     apikey: ENV['BLING_API_KEY']
      #   },
      #   body: {
      #     xml: xml
      #   }
      # }

      # if gerarnfe
      #   options[:body].merge! gerarnfe: 'true'
      # end

      # if Rails.env.development?
      #   puts options
      # end

      # response = HTTParty.post api_url(path), options

      # if Rails.env.development?
      #   puts "Corpo da resposta: #{response.body}"
      #   puts "Corpo do envio: #{response.request.options[:body]}"
      # end

      # response
    end

    def self.get_error_from_response response
      errors = response['retorno']['erros']
      value = nil

      if errors.is_a? Array
        value = errors.first['erro']
      elsif errors.is_a? Hash
        unless errors['erro'].nil?
          value = errors['erro']
        else
          value = errors
        end
      end

      unless value['msg'].nil?
        value
      else
        value['msg'] = value[value.keys.first]
      end

      value
    end
  end
end
