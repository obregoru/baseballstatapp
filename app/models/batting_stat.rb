class BattingStat < ActiveRecord::Base
  belongs_to :player
  attr_accessible :at_bats, :doubles, :hits, :home_runs, :legacy_id, :player_id, :runs_batted, :triples, :batting_year,:league_id, :batting_average, :slugging_percentage
  

  def find_max_batting_avg_by_year_and_league(batting_year, league_id)
    max_bat_avg= BattingStat.where('at_bats >= 400 and batting_year=? and league_id=?', batting_year, league_id).order("batting_average desc")
    if max_bat_avg.first.nil?
      nil
    else
      puts  max_bat_avg.first.player_id 
      max_bat_avg.first.player_id 
    end
  end
 
  def find_max_home_runs_by_year_and_league(batting_year, league_id)
    max_home_runs=BattingStat.where('at_bats >= 400  and batting_year=? and league_id=?', batting_year, league_id).order("home_runs desc")
    if max_home_runs.first.nil?
      nil
    else
      puts max_home_runs.first.player_id 
      max_home_runs.first.player_id 
    end
   
  end
  
  def find_max_runs_batted_by_year_and_league(batting_year, league_id)
    max_batted=BattingStat.where('at_bats >= 400 and batting_year=? and league_id=?', batting_year, league_id).order("runs_batted desc")
    if max_batted.first.nil?
      nil
    else
      puts batting_year
      puts max_batted.first.player_id
      max_batted.first.player_id
    end
       
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
          BattingStat.where("player_id=? and batting_year=?",max_bat_avg, batting_year).first
       else              
         nil
       end 
     end
     
     
   end
end
