class ClaimController < ApplicationController
  def game
    @claims = Claim.claim_game_array
  end
end
