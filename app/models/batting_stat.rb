class BattingStat < ActiveRecord::Base
  belongs_to :player
  attr_accessible :at_bats, :doubles, :hits, :home_runs, :legacy_id, :player_id, :runs_batted, :triples, :batting_year,:league_id, :batting_average, :slugging_percentage
  

  def find_max_batting_avg_by_year_and_league(batting_year, league_id)
    max_bat_avg= BattingStat.order("batting_average desc").first.player_id
 
  end
 
  def find_max_home_runs_by_year_and_league(batting_year, league_id)
    max_home_runs=BattingStat.order("home_runs desc").first.player_id
   
  end
  
  def find_max_runs_batted_by_year_and_league(batting_year, league_id)
    max_batted=BattingStat.order("runs_batted desc").first.player_id

  end
    
   def find_triple_crown_player_by_year_and_league(batting_year, league_id)
     max_bat_avg=self.find_max_batting_avg_by_year_and_league(batting_year, league_id)
     max_home_runs = self.find_max_home_runs_by_year_and_league(batting_year, league_id)
     max_runs_batted_in = self.find_max_runs_batted_by_year_and_league(batting_year, league_id)
   
     triple_crown_winner = 
     if (max_bat_avg.nil? || max_home_runs.nil? || max_runs_batted_in.nil?)
        nil
     else
       if (max_bat_avg==max_home_runs) & (max_home_runs==max_runs_batted_in)
          BattingStat.where("player_id=?",max_bat_avg)
       else              
         nil
       end 
     end
     
     
   end
end
