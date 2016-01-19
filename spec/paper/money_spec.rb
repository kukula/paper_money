require "spec_helper"

describe Paper::Money do
  let(:fifty_eur) { Paper::Money.new(50, 'EUR') }
  let(:twenty_dollars) { Paper::Money.new(20, 'USD') }

  around do |example|
    Paper.configure("EUR", { "USD" => 1.11 })
    example.run
    Paper.reset_configuration
  end

  describe "#inspect" do
    it "returns amount and currency" do
      expect(Paper::Money.new(50, "EUR").inspect).to eq("50.00 EUR")
    end
  end

  describe "#convert_to" do
    it "returns money object with converted amount" do
      expect(Paper::Money.new(50, "EUR").convert_to("USD").inspect).to eq("55.50 USD")
    end

    it "returns money object with converted amount for base currency" do
      expect(Paper::Money.new(55.5, "USD").convert_to("EUR").inspect).to eq("50.00 EUR")
    end

    it "returns same money object if currency is same" do
      expect(Paper::Money.new(55.5, "USD").convert_to("USD").inspect).to eq("55.50 USD")
    end

    it "raises error if currncy is not listed in conversion rates" do
      expect { Paper::Money.new(55.5, "USD").convert_to("XXX").inspect }.to raise_error(Paper::NoCurrencyRate)
    end
  end

  describe "arithmetics" do
    specify "+" do
      expect((fifty_eur + twenty_dollars).inspect).to eq("68.02 EUR")
    end

    specify "-" do
      expect((fifty_eur - twenty_dollars).inspect).to eq("31.98 EUR")
    end

    specify "*" do
      expect((twenty_dollars * 3).inspect).to eq("60.00 USD")
    end

    specify "/" do
      expect((fifty_eur / 2).inspect).to eq("25.00 EUR")
    end
  end

  describe "comparisons" do
    specify "==" do
      expect(twenty_dollars == Paper::Money.new(20, 'USD')).to be_truthy
      expect(twenty_dollars == Paper::Money.new(30, 'USD')).to be_falsey

      fifty_eur_in_usd = fifty_eur.convert_to('USD')
      expect(fifty_eur_in_usd == fifty_eur).to be_truthy
    end

    specify ">" do
      expect(twenty_dollars > Paper::Money.new(5, 'USD')).to be_truthy
    end

    specify "<" do
      expect(twenty_dollars < fifty_eur).to be_truthy
    end
  end
end
