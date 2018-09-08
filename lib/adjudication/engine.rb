require "adjudication/engine/version"
require "adjudication/providers"
require "adjudication/engine/adjudicator"
require "adjudication/engine/claim"

module Adjudication
  module Engine
    def self.run claims_data
         puts 'Begin engine.rb'
      fetcher = Adjudication::Providers::Fetcher.new(Faraday.new(:url => 'http://provider-data.beam.dental/beam-network.csv'))
      provider_data = fetcher.provider_data.map { |provider|Providers::Provider.new(provider)  }

      # TODO filter resulting provider data, match it up to claims data by
      # provider NPI (national provider ID), and run the adjudicator.
      # This method should return the processed claims

      []
    end
  end
end
