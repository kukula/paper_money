module Paper
  class Money
    include Comparable

    attr_reader :cents, :currency

    def initialize(amount, currency = Paper.base_currency)
      @cents = amount * 100
      @currency = currency
    end

    def amount
      cents.to_f / 100
    end

    def inspect
      "#{'%.2f' % amount} #{currency}"
    end

    def convert_to(new_currency)
      return self if new_currency == currency
      unless valid_currency?(new_currency)
        raise NoCurrencyRate, "Currency '#{new_currency}' is not listed in conversion rates"
      end
      Money.new(converted_amount(new_currency), new_currency)
    end

    def +(money)
      sum(money, &:+)
    end

    def -(money)
      sum(money, &:-)
    end

    def *(multiplicator)
      Money.new(amount * multiplicator, currency)
    end

    def /(multiplicator)
      Money.new(amount / multiplicator, currency)
    end

    private

    def <=>(money)
      converted_cents = money.convert_to(currency).cents
      cents <=> converted_cents
    end

    def converted_amount(new_currency)
      if new_currency == Paper.base_currency
        amount / Paper.conversion_rates[currency]
      else
        amount * Paper.conversion_rates[new_currency]
      end
    end

    def valid_currency?(currency)
      Paper.conversion_rates.has_key?(currency) || Paper.base_currency == currency
    end

    def sum(money)
      converted_amount = money.convert_to(currency).amount
      new_amount = yield(amount, converted_amount)
      Money.new(new_amount, currency)
    end
  end
end
