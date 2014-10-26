class Transaction
  CREDENTIALS = ENV["CREDENTIALS"]
  DOMAIN = 'https://apis.bbvabancomer.com/datathon/'
  SERVICES = ['merchants_categories']

  class << self
    def all
      records = []
      cube = RestClient.get DOMAIN + SERVICES[0], request_params
      records.push({:cube => cube})
    end

    def basic_stats_by_zipcode (zipcode, date_min = '201311', date_max = '201404', group_by = 'month')
      service = "zipcodes/#{zipcode}/basic_stats?date_min=#{date_min}&date_max=#{date_max}&group_by=#{group_by}"
      data = call{RestClient.get DOMAIN + service, request_params}
    end

    private
      def request_params
        params = {:authorization => "BASIC #{CREDENTIALS}"
        }
      end

      def call
        begin
          data = JSON.parse yield
        rescue RestClient::Unauthorized => exception
          data = JSON.parse exception.response
        rescue RestClient::ResourceNotFound => exception
          data = JSON.parse exception.response
        rescue RestClient::Exception => exception
          data = JSON.parse exception.response
        ensure
          # do nothing
        end
      end
  end
end
