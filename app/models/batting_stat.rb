class BattingStat < ActiveRecord::Base
  belongs_to :player
  attr_accessible :at_bats, :doubles, :hits, :home_runs, :legacy_id, :player_id, :runs_batted, :triples
end
