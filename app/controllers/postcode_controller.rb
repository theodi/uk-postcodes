class PostcodeController < ApplicationController
  include PostcodeHelper
  
  caches_page :index, :show
  
  before_filter(:only => [:show, :nearest]) { alternate_formats [:json, :xml, :rdf, :csv] }
  
  after_filter do |controller| 
      if controller.params[:callback] && controller.params[:format].to_s == 'json'
        controller.response['Content-Type'] = 'application/javascript'
        controller.response.body = "%s(%s)" % [controller.params[:callback], controller.response.body]
      end
    end

  def index
    
  end
  
  def show
    if params[:id].match(/\s/) || params[:id].match(/[a-z]/)
      postcode = params[:id].gsub(' ', '').upcase
      params[:format] ||= "html"
      redirect_to postcode_url(postcode, format: params[:format]), status: "301"
      return
    end
    
    p = UKPostcode.new(params[:id])
    postcode = p.norm
    @postcode = Postcode.where(:postcode => postcode).first
    
    if postcode == "" || @postcode.nil?
      render_404
      return
    else    
      respond_to do |format|
        format.html
        format.json
        format.xml
        format.rdf { show_rdf(@postcode) }
        format.csv { render :text => @postcode.to_csv }
      end
    end
  end
  
  def nearest
    p = UKPostcode.new(params[:postcode])
    @postcode = Postcode.where(:postcode => p.norm).first
        
    distance = params[:miles].to_f * 1609.344
        
    @postcodes = Postcode.where("ST_Distance(latlng, 'POINT(#{@postcode.lat} #{@postcode.lng})') < #{distance}")    
        
    respond_to do |format|
      format.html
      format.json
      format.xml
      format.rdf { nearest_rdf(@postcodes) }
      format.csv do
        csv = []
        @postcodes.each do |postcode|
          csv << postcode.to_csv
        end
        render :text => csv.join()
      end
    end
  end
  
  def reverse
    if params[:latlng]
      latlng = params[:latlng].split(",")
      params[:lat] = latlng[0]
      params[:lng] = latlng[1]
    end
    
    params[:format] ||= "html"
    
    postcode = Postcode.where("ST_DWithin(latlng, 'POINT(#{params[:lat].to_f} #{params[:lng].to_f})', 1609.344)").first
    p = postcode.postcode.gsub(" ", "")
    redirect_to postcode_url(p, format: params[:format]), status: "303"
  end
  
  def search
    p = UKPostcode.new(params[:q])
    postcode = p.norm.gsub(" ", "")
    redirect_to postcode_url(postcode, format: params[:format]), status: "303"
  end

end