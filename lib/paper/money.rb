module Paper
  class Money
    attr_reader :amount, :currency

    def initialize(amount, currency = Paper.base_currency)
      @amount, @currency = amount, currency
    end

    def inspect
      "#{'%.2f' % amount} #{currency}"
    end
  end
end
