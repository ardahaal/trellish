require 'active_support/concern'
require 'ostruct'

module Trellish
  class Service
    class Result
      attr_reader :status, :success, :data
      alias_method :success?, :success

      def initialize status, data
        @status = status
        @success = status == :success
        @data = data
      end
    end

    def self.call(*args, &block)
      new(*args).call(&block)
    end

    # Shorthand for returning service result.
    #
    # Call it like this:
    #
    #   result(:success) { self.foo = 'bar' }
    #
    # Then result.data.foo will eq 'bar'.
    def result status, &block
      Result.new status, (OpenStruct.new.tap{|os| os.instance_eval(&block)} if block_given?)
    end
  end
end
