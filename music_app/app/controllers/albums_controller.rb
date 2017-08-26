class AlbumsController < ApplicationController
  before_action :ensure_logged_in

  def show
    @album = Album.find(params[:id])
    @band = Band.find(@album.band_id)
  end

  def new
    @band = Band.find(params[:band_id])
    @album = Album.new
  end

  def create
    @album = Album.new(album_params)
    @band = Band.find(@album.band_id)
    if @album.save
      redirect_to band_url(@band)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def edit
    @album = Album.find(params[:id])
    @band = Band.find(@album.band_id)
  end

  def update
    @album = Album.find(params[:id])
    @band = Band.find(@album.band_id)
    if @album.update(album_params)
      redirect_to band_url(@band)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :edit
    end
  end

  def destroy
    Album.find(params[:id]).delete
    redirect_to request.referrer
  end

  private

  def album_params
    params.require(:album).permit(:title, :band_id, :year, :studio, :live)
  end
end
