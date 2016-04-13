require 'httparty'
require "bling/api/base"
require "bling/api/codigo_rastreamento"
require "bling/api/engine"
require "bling/api/exceptions"
require "bling/api/nota_fiscal"
require "bling/api/pedido"
require "bling/api/transporte"
require "bling/api/version"
require "bling/api/pedidos/cliente"
require "bling/api/pedidos/item"
require "bling/api/pedidos/parcela"
require "bling/api/transportes/endereco_entrega"
require "bling/api/transportes/volume"



API_URL = "https://bling.com.br/Api/v2/"

module Bling
  module Api
    
    class << self; attr_accessor :apikey; end

    def self.api_url path
      File.join path, "/json/"
    end

    def self.get path, filters=""
      conn = Faraday.new(API_URL)

      conn.get do |req|                           
        req.url "#{api_url(path)}", apikey: Bling::Api.apikey
        req.params['filters'] = filters
      end
    end


    def self.post path, resource, attributes={}


      options = {
        apikey: Bling::Api.apikey,
        xml: resource.to_xml,
        gerarnfe: false
      }


      # if Rails.env.development?
      #   puts options
      # end


      conn = Faraday.new(API_URL)
  
      conn.post do |req|                           
        req.url "#{api_url(path)}"
        # req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
       
        req.body = options
      end

      # if nfe = attributes[:nfe]
      #   options.merge! gerarnfe: 'true'
      #   byebug
      # end
      
      # response = HTTParty.post api_url(File.join(API_URL, path)), query: { apikey: Bling::Api.apikey }, body: { xml: resource.to_xml }
      
      # response = HTTParty.post File.join(API_URL, api_url(path)), query: { apikey: Bling::Api.apikey, xml: resource.to_xml } #, body: {  }


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
