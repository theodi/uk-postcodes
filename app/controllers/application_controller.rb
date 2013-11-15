class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def render_404
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found }
      format.any  { head :not_found }
    end
  end
  
  def static
    render "static/#{params[:page]}" rescue render_404
  end

end
