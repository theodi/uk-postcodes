# Load the rails application
require File.expand_path('../application', __FILE__)
Mime::Type.register "application/rdf+xml", :rdf
Mime::Type.register "text/n3", :n3

# Initialize the rails application
UkPostcodes::Application.initialize!
