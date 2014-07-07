require_relative '../../lib/BaseballStats.rb'

class PlayerAwardsController < ApplicationController
  
  before_filter :authenticate_user!,
     :only => [:destroy, :edit, :new, :create, :create_awards]
  # GET /player_awards
  # GET /player_awards.json
  include BaseballStats


  def create_awards
=begin   
    BattingStat.all.each do |bs|
  
      bs.batting_average = battingAverage(bs.hits, bs.at_bats)
      bs.slugging_percentage  = sluggingPercentage(bs.hits, bs.doubles, bs.triples, bs.home_runs, bs.at_bats)
      bs.save
    end
=end  
    #update stats
    
    
    #Validation failed: Award year can't be blank, Award year is not a number, Award year should be a four-digit year
    
    PlayerAward.destroy_all
    batting_year = 2012
     BattingStat.new.find_players_with_batting_data_by_year(batting_year).each do |bs|
        puts 'updating batting stats for player >>>>>>>> ' +  bs.player_id.to_s
       BattingStat.new.find_prior_year_and_next_year(batting_year, bs.player_id)
    end  
    
    #most imporoved award
    most_improved = BattingStat.new.find_highest_batting_average_diff_by_year(batting_year)
    if !(most_improved.nil?)
      award=PlayerAward.new
      award.league_id=most_improved.league_id
      award.award_name= batting_year.to_s + ' Most Improved Batting Average'
      award.player_id = most_improved.player_id
      award.award_year = batting_year 
      begin
        award.save!
      rescue Exception =>e
        raise e.to_s
      end
    end
    
    #get_slugging_percentage_for_team(team_id, year)
    year=2012
    team_id=1
    team_slugging_percentage=BattingStat.new.get_sum_team_batting_stats(team_id, year)
    if !(team_slugging_percentage.nil?)
      award=PlayerAward.new
      award.league_id=team_slugging_percentage.league_id
      award.award_name= batting_year.to_s + ' Team Slugging Percentage: ' + 0
      award.player_id = most_improved.player_id
      award.award_year = batting_year 
    end
    
    (1..2).each do |league|
    (2005..2012).each do |batting_year|
      triple_crown_winner= BattingStat.new.find_triple_crown_player_by_year_and_league(batting_year,league)
      puts 'triple crown winner ->' + triple_crown_winner.to_yaml
      if !(triple_crown_winner.nil?)
        existing_award= PlayerAward.where('award_name = ? and award_year=? and league_id=?', 'Triple Crown',batting_year.to_s, triple_crown_winner.league_id ).first
        if !(existing_award.nil?)
          existing_award.destroy
        end
        award = PlayerAward.new
        award.league_id = triple_crown_winner.league_id
        award.player_id = triple_crown_winner.player_id
        award.award_name = "Triple Crown"
        award.award_year = batting_year
        award.save
      end 
    end
  end
  
 
   


 
      redirect_to '/player_awards', :notice=>'Awards created'

  end
  def index
    @player_awards = PlayerAward.includes(:player,:league).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @player_awards }
    end
  end

  # GET /player_awards/1
  # GET /player_awards/1.json
  def show
    @player_award = PlayerAward.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @player_award }
    end
  end

  # GET /player_awards/new
  # GET /player_awards/new.json
  def new
    @player_award = PlayerAward.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @player_award }
    end
  end

  # GET /player_awards/1/edit
  def edit
    @player_award = PlayerAward.find(params[:id])
  end

  # POST /player_awards
  # POST /player_awards.json
  def create
    @player_award = PlayerAward.new(params[:player_award])

    respond_to do |format|
      if @player_award.save
        format.html { redirect_to @player_award, notice: 'Player award was successfully created.' }
        format.json { render json: @player_award, status: :created, location: @player_award }
      else
        format.html { render action: "new" }
        format.json { render json: @player_award.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /player_awards/1
  # PUT /player_awards/1.json
  def update
    @player_award = PlayerAward.find(params[:id])

    respond_to do |format|
      if @player_award.update_attributes(params[:player_award])
        format.html { redirect_to @player_award, notice: 'Player award was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @player_award.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /player_awards/1
  # DELETE /player_awards/1.json
  def destroy
    @player_award = PlayerAward.find(params[:id])
    @player_award.destroy

    respond_to do |format|
      format.html { redirect_to player_awards_url }
      format.json { head :no_content }
    end
  end
end
