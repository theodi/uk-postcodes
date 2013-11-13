# Load the rails application
require File.expand_path('../application', __FILE__)
Mime::Type.register "application/rdf+xml", :rdf

# Initialize the rails application
UkPostcodes::Application.initialize!
