class PlayerAwardsController < ApplicationController
  # GET /player_awards
  # GET /player_awards.json
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