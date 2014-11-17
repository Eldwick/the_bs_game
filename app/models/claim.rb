class Claim < ActiveRecord::Base
  def self.claim_game_array
    lies = Claim.where(truth: false).shuffle[0..3]
    truth = Claim.where(truth: true).shuffle[0]
    lies << truth
    lies.shuffle
  end
end
