require "bling/api/version"
require "bling/api/base"
require "bling/api/nota_fiscal"
require "bling/api/exceptions"

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
