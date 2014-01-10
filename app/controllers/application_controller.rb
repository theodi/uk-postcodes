class ApplicationController < ActionController::Base
  protect_from_forgery
  
  caches_page :static
  
  def render_error(code, reason)
    @code = code
    @error = reason
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/#{code}", :layout => false, :status => code }
      format.json { render :template => "application/error", :status => :not_found }
      format.xml { render :template => "application/error", :status => :not_found }
      format.rdf { render :file => "#{Rails.root}/public/404", :layout => false, :status => code }
      format.csv { render :file => "#{Rails.root}/public/404", :layout => false, :status => code }
    end
  end
  
  def static
    render "static/#{params[:page]}" rescue render_404
  end

end
