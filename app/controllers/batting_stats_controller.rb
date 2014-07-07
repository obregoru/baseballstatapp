class BattingStatsController < ApplicationController
  
  before_filter :authenticate_user!,
     :only => [:destroy, :edit, :new, :create]
     
     
  # GET /batting_stats
  # GET /batting_stats.json
  def index
    @batting_stats = BattingStat.includes(:player,:team).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @batting_stats }
    end
  end

  # GET /batting_stats/1
  # GET /batting_stats/1.json
  def show
    @batting_stat = BattingStat.includes(:team).find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @batting_stat }
    end
  end

  # GET /batting_stats/new
  # GET /batting_stats/new.json
  def new
    @batting_stat = BattingStat.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @batting_stat }
    end
  end

  # GET /batting_stats/1/edit
  def edit
    @batting_stat = BattingStat.find(params[:id])
  end

  # POST /batting_stats
  # POST /batting_stats.json
  def create
    @batting_stat = BattingStat.new(params[:batting_stat])

    respond_to do |format|
      if @batting_stat.save
        format.html { redirect_to @batting_stat, notice: 'Batting stat was successfully created.' }
        format.json { render json: @batting_stat, status: :created, location: @batting_stat }
      else
        format.html { render action: "new" }
        format.json { render json: @batting_stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /batting_stats/1
  # PUT /batting_stats/1.json
  def update
    @batting_stat = BattingStat.find(params[:id])

    respond_to do |format|
      if @batting_stat.update_attributes(params[:batting_stat])
        format.html { redirect_to @batting_stat, notice: 'Batting stat was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @batting_stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /batting_stats/1
  # DELETE /batting_stats/1.json
  def destroy
    @batting_stat = BattingStat.find(params[:id])
    @batting_stat.destroy

    respond_to do |format|
      format.html { redirect_to batting_stats_url }
      format.json { head :no_content }
    end
  end
end
