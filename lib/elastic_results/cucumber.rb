require 'cucumber/formatter/json'
require 'elastic_results'
require 'elastic_results/cucumber/reportable'

module ElasticResults
  module Cucumber
    class Formatter < ::Cucumber::Formatter::Json
      include Reportable

      def on_test_case_finished(event)
        test_case, result = *event.attributes

		#old_after_feature_element test_case, result
		#old_after_feature_element test_case, result

        feature_hash = @feature_hashes.last
        feature_hash[:elements].each do |scenario_hash|
          record_scenario feature_hash, scenario_hash
        end
        
      end
      alias_method :old_after_feature_element, :on_test_case_finished

      def on_test_run_finished(_event)
        puts "ok"
        ElasticResults.write_urls
      end
    end
  end
end
