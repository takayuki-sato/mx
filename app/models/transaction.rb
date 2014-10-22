class Transaction
  CREDENTIALS = ENV["CREDENTIALS"]
  SERVICES = ['https://apis.bbvabancomer.com/datathon/info/merchants_categories']

  class << self
    def all
      records = []
      cube = RestClient.get SERVICES[0], request_params
      records.push({:cube => cube})
    end

    private
      def request_params
        params = {:authorization => "BASIC #{CREDENTIALS}"
        }
      end
  end
end
