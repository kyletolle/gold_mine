require './lib/gold_mine'

describe GoldMine do
  let(:gold_chest) { described_class.new }
  subject          { gold_chest }

  describe "#begin_mining" do
    describe "when run once" do
      it "returns last_collected_at" do
        expect(subject.begin_mining).to eq subject.last_collected_at
      end
    end

    describe "when run a second time" do
      before { subject.begin_mining }
      it "returns nil" do
        expect(subject.begin_mining).to eq nil
      end
    end
  end

  describe "#last_collected_at" do
    describe "before mining begins" do
      it "is nil" do
        expect(subject.last_collected_at).to be_nil
      end
    end

    describe "after mining starts" do
      before { subject.begin_mining }

      let(:expected_last_collected_at) { Time.now.to_i }

      it "is set" do
        expect(subject.last_collected_at).to eq expected_last_collected_at
      end
    end
  end

  describe "#mining?" do
    describe "before mining begins" do
      it "is false" do
        expect(subject.mining?).to be_falsey
      end
    end

    describe "after mining starts" do
      before { subject.begin_mining }

      it "is true" do
        expect(subject.mining?).to be_truthy
      end
    end
  end

  describe " #amount_uncollected" do
    describe "before mining begins" do
      it "is nil" do
        expect(subject.amount_uncollected).to be_nil
      end
    end

    describe "after mining begins" do
      before { subject.begin_mining }

      it "initially is 0" do
        expect(subject.amount_uncollected).to eq 0
      end

      describe "after 5 seconds" do
        before do
          sleep 5
        end

        it "accumulates 1 per second" do
          expect(subject.amount_uncollected).to eq 5
        end
      end
    end
  end

  describe "collect_gold" do
    describe "before mining begins" do
      it "is nil" do
        expect(subject.collect_gold).to be_nil
      end
    end

    describe "after mining begins" do
      before do
        subject.begin_mining
        sleep 5
      end

      it "returns the amount of gold uncollected" do
        expected_gold_collected = subject.amount_uncollected

        expect(subject.collect_gold).to eq expected_gold_collected
      end

      it "resets last_collected_at" do
        previous_last_collected_at = subject.last_collected_at
        subject.collect_gold

        expect(subject.last_collected_at).not_to eq previous_last_collected_at
      end
    end
  end
end

