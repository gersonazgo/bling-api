#lib/bling/api/base.rb
module Bling
  module Api
    class Base

      def self.find id
        response = Bling::Api.get("#{object_type}/#{id}/")
        response = JSON.parse(response.body)
        
        if response['retorno']['erros'].nil?
          self.new response['retorno'][path].first[object_type]
        else
          raise BlingResourceNotFound.new(Bling::Api.get_error_from_response(response))
        end


        # response = Bling::Api.get("#{API_URL}/#{serie}/#{numero}/json", { :apikey => ENV['BLING_API_KEY'] })
        # attributes = JSON.parse(response.body)
        # new(attributes["retorno"]["notasfiscais"][0]["notafiscal"])
      end

      def self.all attributes={}
        elements = []
        response = nil

        # Set filters from attributes
        filters = set_filters(attributes)

        # Works with pagination if page is defined
        page = attributes[:page]
        if page.nil?
          page = 0
          while response.nil? or response['retorno']['erros'].nil? == false
            page += 1

            response = Bling::Api.get("#{path}/page=#{page}/", filters)

            response = JSON.parse(response.body)
            break unless response['retorno']['erros'].nil?

            response['retorno'][path].each do |p|
              elements.push self.new(p[object_type])
            end
          end
        else 
          response = Bling::Api.get("#{path}/page=#{page}/", filters)
          response = JSON.parse(response.body)
          if response['retorno']['erros'].nil?
            response['retorno'][path].each do |p|
              elements.push self.new(p[object_type])
            end
          else
            raise BlingResourceNotFound.new(Bling::Api.get_error_from_response(response))
          end
        end

        # Returns the elements
        elements
      end

      def save attributes={}
        response = Bling::Api.post("#{save_path}/", self, attributes)

        response = JSON.parse(response.body)
        if response['retorno']['erros'].nil?
          self
        else
          raise BlingResourceNotFound.new(Bling::Api.get_error_from_response(response))
        end
      end



    end
  end
end