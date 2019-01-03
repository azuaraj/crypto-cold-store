require 'rails_helper'

RSpec.describe CheckTxsJob do

  it "inherits from ApplicationJob" do
    expect(described_class < ApplicationJob).to be true
  end

  it "is unique until_executed" do
    expect(described_class.sidekiq_options["unique"]).to eq :until_executed
  end

  it "logs on conflict" do
    expect(described_class.sidekiq_options["on_conflict"]).to eq :log
  end

  it "expires the lock automatically" do
    expect(described_class.sidekiq_options["lock_expiration"]).
      to eq 2.minutes
  end

  %w(btc eth).each do |coin|
    # NOTE: not all Block::COINS are synced, yet
    context "given the arg #{coin}" do
      it "delegates work to #{coin.classify}::CheckTxs" do
        target_klass = coin.classify.constantize.const_get("CheckTxs")
        expect(target_klass).to receive(:call)
        described_class.new.perform(coin)
      end
    end
  end

end
