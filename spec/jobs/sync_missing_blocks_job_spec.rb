require 'rails_helper'

RSpec.describe SyncMissingBlocksJob do

  it "inherits from ApplicationJob" do
    expect(described_class < ApplicationJob).to be true
  end

  %w(btc eth).each do |coin|
    # NOTE: not all Block::COINS are synced, yet
    context "given the arg `#{coin}`" do
      it "delegates work to #{coin.classify}::SyncMissingBlocks" do
        expect(SyncMissingBlocks).to receive(:call).with(coin)
        described_class.new.perform(coin)
      end
    end
  end

end
