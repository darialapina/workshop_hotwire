class Artists::TracksController < ApplicationController
  PER_PAGE = 25

  def index
    next_page = all_tracks.count > current_page * PER_PAGE ? current_page + 1 : nil

    if turbo_frame_request?
      render partial: "tracks",
             locals: { artist:, tracks:, current_page:, next_page:  }
    else
      render :index, locals: { artist:, tracks:, current_page:, next_page:  }
    end
  end
  
  private

  def tracks
    all_tracks.popularity_ordered.limit(PER_PAGE).offset(PER_PAGE * current_page)
  end

  def all_tracks
    @all_tracks ||= artist.tracks
  end

  def current_page
    params[:page].to_i || 0
  end
  
  def artist
    @artist ||= Artist.find(params[:artist_id])
  end
end
