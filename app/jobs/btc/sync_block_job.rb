module Btc
  class SyncBlockJob < ApplicationJob

    sidekiq_options unique: :until_executed, queue: "btc"

    def perform(block_height)
      SyncBlock.(block_height)
    end

  end
end
