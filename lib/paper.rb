require "paper/version"
require "paper/money"

module Paper
  class NoCurrencyRate < RuntimeError; end

  def self.configure(base_currency:, conversion_rates:)
    @base_currency, @conversion_rates = base_currency, conversion_rates
  end

  def self.reset_configuration
    @base_currency = @conversion_rates = nil
  end

  def self.base_currency
    @base_currency || 'EUR'
  end

  def self.conversion_rates
    @conversion_rates || {}
  end
end
