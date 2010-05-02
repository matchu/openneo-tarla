class AllClearsController < ApplicationController
  def create
    all_clear = AllClear.new params[:all_clear]
    all_clear.ip = request.remote_ip
    if all_clear.save
      flash[:notice] = 'Thanks! All clear!'
    else
      flash[:alert] = 'Error saving all clear. Was that a real location?'
    end
    redirect_to locations_path
  end
end
