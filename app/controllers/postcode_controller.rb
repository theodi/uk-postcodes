class PostcodeController < ApplicationController
  include PostcodeHelper
  
  before_filter(:only => [:show]) { alternate_formats [:json, :xml, :rdf, :csv] }

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
        format.rdf { dump_graph(@postcode) }
        format.csv { render :text => @postcode.to_csv }
      end
    end
  end
  
  def nearest
    p = UKPostcode.new(params[:postcode])
    @postcode = Postcode.where(:postcode => p.norm).first
    radius = params[:miles].to_f / 69.to_f
    @postcodes = Postcode.within_circle(latlng: [@postcode.latlng.to_a, radius]).includeLocs(true)
    @postcodes.sort_by!{|p| p.distance_from(@postcode.latlng)}
    
    respond_to do |format|
      format.html
      format.json
      format.xml
      format.rdf { dump_graph(@postcodes) }
      format.csv do
        csv = []
        @postcodes.each do |postcode|
          csv << postcode.to_csv
        end
        render :text => csv.join
      end
    end
  end
  
  def reverse
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