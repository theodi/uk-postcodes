class PostcodeController < ApplicationController
  include PostcodeHelper
  
  before_filter(:only => [:show, :nearest]) { alternate_formats [:json, :xml, :rdf, :csv] }

  def index
    
  end
  
  def show
    if params[:id].match(/\s/) || params[:id].match(/[a-z]/)
      postcode = params[:id].gsub(' ', '').upcase
      params[:format] ||= "html"
      redirect_to postcode_url(postcode, format: params[:format].downcase), status: :moved_permanently
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
    # This is a rough conversion to radians
    radius = params[:miles].to_f / 69
    @postcodes = Postcode.within_circle(latlng: [@postcode.latlng.to_a, radius]).to_a
    # Remove any postcodes with a distance of more than the number of miles (there should only be a few)
    @postcodes.select!{|p| p.distance_from(@postcode.latlng) < params[:miles].to_f}
    @postcodes.sort_by!{|p| p.distance_from(@postcode.latlng)}
    
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
    
    postcode = Postcode.geo_near([params[:lat].to_f, params[:lng].to_f]).first
    p = postcode.postcode.gsub(" ", "")
    redirect_to postcode_url(p, format: params[:format].downcase)
  end
  
  def search
    p = UKPostcode.new(params[:q])
    postcode = p.norm.gsub(" ", "")
    redirect_to postcode_url(postcode, format: params[:format].downcase), status: :moved_permanently
  end

end