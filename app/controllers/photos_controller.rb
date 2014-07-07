class PhotosController < ApplicationController
   before_filter :load_imageable
   before_filter :authenticate_user!,
      :only => [:destroy, :edit, :new, :create]
  # GET /photos
  # GET /photos.json
  def index
   # @photos = Photo.all
  
   @imageable = find_imageable
   @photos= if !(@imageable.nil?)
     @imageable.photos
   else
     Photo.all
   end
   
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @photos }
    end
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
    @photo = Photo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @photo }
    end
  end




  # GET /photos/1/edit
  def edit
    @photo = Photo.find(params[:id])
  end


  # GET /photos/new
  # GET /photos/new.json
  def new
    @photo = @imageable.photos.new
     resource, id = request.path.split('/')[1, 2]
    @name = case resource
      when "leagues"
       @imageable.league_name
      when "teams"
        @imageable.team_name
      when "players"
        @imageable.first_name + ' ' + @imageable.last_name
      else
        nil
    end

  end
  
  # POST /photos
  # POST /photos.json
  def create
      @photo =Photo.new(:imageable_id=>params[:photo][:imageable_id], :imageable_type=>params[:photo][:imageable_type],:file_name=>params[:photo][:file_name],:photo_name=>params[:photo][:photo_name])
      if @photo.save
    
        redirect_to '/' + params[:photo][:imageable_type].pluralize.downcase  + '/' + params[:photo][:imageable_id], notice: "Photo was successfully created."
      else
        render :new
      end
  end

  # PUT /photos/1
  # PUT /photos/1.json
  def update
    @photo = Photo.find(params[:id])

    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to photos_url }
      format.json { head :no_content }
    end
  end
  
private
  
  
  def find_imageable
     params.each do |name, value|
       if name =~ /(.+)_id$/
         return $1.classify.constantize.find(value)
       end
     end
     nil
  end
  def load_imageable
    resource, id = request.path.split('/')[1, 2]
    if id
      @imageable = resource.singularize.classify.constantize.find(id) 
    end
  end
  
end
