class BattingStat < ActiveRecord::Base
  belongs_to :player
  belongs_to :team
  belongs_to :league
  
  validates :player_id, presence: true
  validates :team_id, presence: true
  validates :league_id, presence: true
   
  attr_accessible :at_bats, :doubles, :hits, :home_runs, :legacy_id, :player_id, :runs_batted, :triples, :batting_year,:league_id, :batting_average, :slugging_percentage, :team_id, :batting_average_difference
  
  

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
   
   def find_prior_year_and_next_year(batting_year, player_id)
     puts ' processing player ' + player_id.to_s
     two_years_batting_stats=BattingStat.where('player_id=? and (batting_year=? or batting_year=?)', player_id, batting_year, batting_year-1).order('batting_year desc').select("id, batting_average, player_id,team_id, league_id, batting_average_change").all
     batting_average_change = 
       if two_years_batting_stats.count>1
           two_years_batting_stats.first.batting_average -  two_years_batting_stats.last.batting_average
         else
           0
       end
     # two_years_batting_stats.first.batting_average_change = batting_average_change
     batting_stat_id= two_years_batting_stats.first.id

     begin
       batstat =BattingStat.find(batting_stat_id)
       batstat.batting_average_difference= batting_average_change
       batstat.save!
     rescue Exception=>e
       raise e.to_s
     end   
      
   end 
   def find_players_with_batting_data_by_year(batting_year)
     players=BattingStat.where('batting_year=?', batting_year).order('player_id asc').select("player_id").all
   end
   
   def find_highest_batting_average_diff_by_year(batting_year)
     BattingStat.order('batting_average_difference desc').first
   end
   # Slugging percentage for all players on the Oakland A's in 2007.
   #Hits - doubles - triples - home runs) + (2 * doubles) + (3 * triples) + (4 * home runs)) / at-bats
   def get_sum_team_batting_stats(team_id, year)
     team_stats=BattingStat.group(:league_id, :team_id, :batting_year)
     .select("league_id, team_id, batting_year, SUM(hits) as sum_hits, sum(doubles) as sum_doubles, sum(triples) as sum_triples, sum(home_runs) as sum_home_runs, sum(at_bats) as sum_at_bats")
     .order('team_id')
     .where('team_id=? and batting_year=?', team_id, year).first
     return team_stats
 
   end
   
end
