require "spec_helper"

describe Paper::Money do
  describe "#inspect" do
    it "returns amount and currency" do
      expect(Paper::Money.new(50, "EUR").inspect).to eq("50.00 EUR")
    end
  end
end
