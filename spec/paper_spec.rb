require "spec_helper"

describe Paper do
  it "has a version number" do
    expect(Paper::VERSION).not_to be_nil
  end

  describe '.configure' do
    after { Paper.reset_configuration }

    it "sets base currency" do
      expect { configurate_base_and_rates }.to \
        change { Paper.base_currency }.from("EUR").to("UAH")
    end

    it "sets conversion rates" do
      expect { configurate_base_and_rates }.to \
        change { Paper.conversion_rates }.from({}).to({ "USD" => 4.2 })
    end
  end

  describe ".reset_configuration" do
    before { configurate_base_and_rates }

    it "resets configuration to default" do
      expect { Paper.reset_configuration }.to \
        change { Paper.base_currency }.from("UAH").to("EUR")
    end
  end

  def configurate_base_and_rates
    Paper.configure(base_currency: "UAH", conversion_rates: { "USD" => 4.2 })
  end
end
