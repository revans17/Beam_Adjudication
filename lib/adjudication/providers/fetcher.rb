require 'Faraday'
require 'CSV'
require 'mini_cache'
require 'adjudication/providers'


module Adjudication
  module Providers
    class Fetcher

         def initialize(http_client)
              @http_client = http_client
              @npiIndex = nil
              @keys = nil
         end


      #Gets the data from the providers
      def provider_data
        providers = []
        get_csv_data.each_with_index do |row, i|
             if i == 0
                  @keys = row
                  find_npi_index(@keys)
                  next
             end
             if self.is_valid_provider? row
                  proviers.push(Hash[@keys.zip(row)])
             else
                  STDERR.puts 'Invalid provider NPI' + row.inspect
             end
        end
             return providers
      end

      #True if something is a number
      def is_number? string
           true if Float(string) rescue false
      end


     #Checks for a valid NPI
     def is_valid_provider? provider_row
          return is_number?(provider_row[@npi_index]) && provider_row[@npi_index].to_s.length == 10
     end


      #returns the index of the NPI
      def getNPIIndex
           return @npiIndex
      end

      def cache
           @cache ||= MiniCache::Store.new
      end

      #Gets the row for the NPI index
      def find_npi_index(row)
           row.each_with_index do |column_title, index|
                if column_title.upcase == 'NPI'
                     @npiIndex = index
                     break
                end
           end
           if @npiIndex = index
                output = 'Index for NPI not found'
                STDERR.puts output
                raise output
           end
      end
      #Returns the data from the CSV file
      def get_csv_data
           cached_providers = self.cache.get('providers-data')
           if cached_providers
                return cached_providers
           end
           response = @http_client.get '/beam-network.csv'
           cached_providers = CSV.parse(response.body)
           self.cache.set('cached-providers', cached_providers, expires_in: 300)
           return cached_providers
      end


    end
  end
end
