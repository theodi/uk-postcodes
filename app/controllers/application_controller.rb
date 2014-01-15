class ApplicationController < ActionController::Base
  protect_from_forgery
  
  caches_page :static
  
  def render_error(code, reason)
    @code = code
    @error = reason
    respond_to do |format|
      format.html { render :file => "application/error", :status => code }
      format.json { render :template => "application/error", :status => code }
      format.xml { render :template => "application/error", :status => code }
      format.rdf { render :file => "application/error.html", :content_type => 'text/html', :status => code }
      format.csv { render :file => "application/error.html", :content_type => 'text/html', :status => code }
    end
  end
  
  def static
    render "static/#{params[:page]}" rescue render_404
  end

end
