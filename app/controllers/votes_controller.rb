class VotesController < ApplicationController
  def create
    vote = Vote.new params[:vote]
    vote.ip = request.remote_ip
    if vote.save
      flash[:notice] = 'Vote saved'
    else
      flash[:alert] = 'Error saving vote. Have you already voted on this?'
    end
    redirect_to sightings_path
  end
end
