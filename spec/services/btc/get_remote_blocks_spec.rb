require 'rails_helper'

module Btc
  RSpec.describe GetRemoteBlocks do

    let(:client) { InitBitcoinerClient.execute.bitcoiner_client }

    it "returns the blocks with all their txs", vcr: {record: :once} do
      resulting_ctx = described_class.execute(
        block_hashes: [
          "000000000000006f7cef9ff5d73c81eec620a75a05856c4d1f2ad40e009fdfad",
          "000000000000009c184b9d16641b5fa81b9c917c29db56a2ccd9396be82992bb",
        ],
        bitcoiner_client: client,
      )

      remote_blocks = resulting_ctx.remote_blocks
      expect(remote_blocks[0]["tx"]).to_not be_empty
      expect(remote_blocks[0]["tx"].first["txid"]).
        to eq "abb5a6c6a6fce9f292376ed87c3669894cdede05729e4475617fc9f5189a7d47"

      expect(remote_blocks[1]["tx"]).to_not be_empty
      expect(remote_blocks[1]["tx"].first["txid"]).
        to eq "eb4f4334a830a7cb9587e781a493109605f12109f4cc2bd65f4cde1c9f0b4953"
    end

  end
end
