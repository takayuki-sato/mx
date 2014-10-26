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

    def merchants_categories
      call 'info/merchants_categories'
    end

    def basic_stats_by_zipcode (zipcode, date_min = '201311', date_max = '201404', group_by = 'month')
      call make_url('basic_stats', zipcode, date_min, date_max, group_by)
    end

    def customer_zipcodes_by_zipcode (zipcode, date_min = '201311', date_max = '201404', group_by = 'month', by = 'income')
      call make_url('customer_zipcodes', zipcode, date_min, date_max, group_by, "&by=#{by}")
    end

    def age_distribution_by_zipcode (zipcode, date_min = '201311', date_max = '201404', group_by = 'month', by = 'income')
      call make_url('age_distribution', zipcode, date_min, date_max, group_by)
    end

    def gender_distribution_by_zipcode (zipcode, date_min = '201311', date_max = '201404', group_by = 'month', by = 'income')
      call make_url('gender_distribution', zipcode, date_min, date_max, group_by)
    end

    def payment_distribution_by_zipcode (zipcode, date_min = '201311', date_max = '201404', group_by = 'month', by = 'income')
      call make_url('payment_distribution', zipcode, date_min, date_max, group_by)
    end

    def category_distribution_by_zipcode (zipcode, date_min = '201311', date_max = '201404', group_by = 'month', by = 'income')
      call make_url('category_distribution', zipcode, date_min, date_max, group_by)
    end

    def consumption_pattern_by_zipcode (zipcode, date_min = '201311', date_max = '201404', group_by = 'month', by = 'income')
      call make_url('consumption_pattern', zipcode, date_min, date_max, group_by)
    end

    def cards_cube_by_zipcode (zipcode, date_min = '201311', date_max = '201404', group_by = 'month', by = 'income')
      call make_url('cards_cube', zipcode, date_min, date_max, group_by)
    end

    def payments_cube_by_zipcode (zipcode, date_min = '201311', date_max = '201404', group_by = 'month', by = 'income')
      call make_url('payments_cube', zipcode, date_min, date_max, group_by)
    end

    private
      def request_params
        params = {:authorization => "BASIC #{CREDENTIALS}"
        }
      end

      def call (service)
        begin
          data = JSON.parse RestClient.get(DOMAIN + service, request_params)
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

      def make_url (name, zipcode, date_min, date_max, group_by, optional = '')
        "zipcodes/#{zipcode}/#{name}?date_min=#{date_min}&date_max=#{date_max}&group_by=#{group_by}#{optional}"
      end
  end
end
