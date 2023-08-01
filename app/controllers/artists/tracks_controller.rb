class Artists::TracksController < ApplicationController
  def index
    show_next_page = all_tracks.count > page * 5

    render partial: "tracks",
           locals: { artist:, tracks:, current_page: page, show_next_page: }
  end
  
  private

  def tracks
    all_tracks.popularity_ordered.limit(5).offset(5 * page)
  end

  def all_tracks
    @all_tracks ||= artist.tracks
  end

  def page
    params[:page].to_i+1 || 1
  end
  
  def artist
    @artist ||= Artist.find(params[:artist_id])
  end
end
