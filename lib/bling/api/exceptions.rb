module Bling
  module Api
    class BlingApiError < StandardError
      attr_reader :data

      def initialize data
        @data = data
      end

      def message
        data['msg']
      end

      def code
        data['cod']
      end
    end

    class BlingResourceNotFound < BlingApiError
    end



  end
end