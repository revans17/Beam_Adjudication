module Adjudication
  module Engine
    class Adjudicator
      attr_reader :processed_claims

      def initialize
        @processed_claims = []
      end


      def adjudicate(claim)
           claim.line_items.map { |line_item|
           if line_item.preventive_and_diagnostic:
                line_item.pay! (line_item.charged)
           elsif line_item.ortho?
                line_item.pay! (line_item.charged * 0.25)
           else
                line_item.reject!
                STDERR.puts 'Rejected line item ' + line_item.inspect
           end
           line_item
      }
      processed_claims(claim)
        # TODO implement adjudication rules, and add any processed claims (regardless
        # of status) into the processed_claims attribute.

      end
    end
  end
end
