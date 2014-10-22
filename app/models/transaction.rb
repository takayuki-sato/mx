class Transaction

  class << self
    def all
      records = []
      cube = RestClient.get 'http://www.yahoo.co.jp'
      records.push({:cube => cube})
      return records
    end
  end
end
