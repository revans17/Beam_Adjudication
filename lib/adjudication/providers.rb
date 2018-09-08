require "adjudication/providers/fetcher"

module Adjudication
  module Providers
       class Provider
            attr_accessor(
                 :firstName,
                 :lastName,
                 :npi,
                 :practiceName,
                 :address1,
                 :address2,
                 :city,
                 :state,
                 :zip,
                 :speciality
            )
            def initialize providerHash
                 @firstName = providerHash['First Name']
                 @lastName = providerHash['Last Name']
                 @npi = providerHash['NPI']
                 @practiceName = providerHash['Practice Name']
                 @address1 = providerHash['Address Line 1']
                 @address2 = providerHash['Address Line 2']
                 @city = providerHash['City']
                 @state = providerHash['State']
                 @zip = providerHash['Zip']
                 @speciality = providerHash['Speciality']
            end
       end
  end
end
