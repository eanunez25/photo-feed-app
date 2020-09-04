class StaticPagesController < ApplicationController
  def home
    FlickRaw.api_key = ENV["api_key"]
    FlickRaw.shared_secret = ENV["shared_secret"]

    @user_id = params[:id]
    if @user_id
      @user = flickr.people.getInfo(user_id: @user_id)
      @photos = flickr.people.getPublicPhotos(user_id: @user_id)
      @urls = []
      @photos.each do |p|
        info = flickr.photos.getInfo(photo_id: p.id)
        url = FlickRaw.url(info)
        @urls << url
      end
    end
  end
end
