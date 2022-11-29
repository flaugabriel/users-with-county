module Om30
  module Operation
    require_relative 'result'

    module Base
      attr_accessor :result, :logger

      def initialize(logger: Rails.logger, result: Om30::Operation::Result.new)
        @result = result
        @logger = logger
      end

      def call(params = {})
        run(params)
        result
      end

      def run(params = {})
        return unless result.success?

        catch :abort do
          self.validate(params)
          self.process(params) if result.success?
        end
        result.success?
      rescue StandardError => e
        if self.respond_to?(:logger) && logger.present?
          logger.error(e.message)
          logger.error(e.backtrace)
        end

        result
      end

      def process(params)
        raise NotImplementedError,
              "You should implement method:\n   process(params)"
      end

      def validate(params)
        # optional implementation
      end
    end
  end
end
