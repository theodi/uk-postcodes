class Code
  include Mongoid::Document
  
  field :name, type: String
  field :snac, type: String
  field :os, type: String
  field :gss, type: String
  field :type, type: String
  
  index({ gss: 1 }, { unique: true, name: "gss_index" })
end