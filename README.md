# UK Postcodes

This is the next generation version of [http://www.uk-postcodes.com](http://www.uk-postcodes.com). The functionality is largely unchanged, but improvements include:

* Better codebase (bye bye PHP)
* MongoDB backend
* (Hopefully) better support
* New design
* Easy setup for local installs

## Running a local version

I've included all the necessary data in this repo (which I will keep updated). To get this up and running locally (I'm assuming you have a local instance of MongoDB running, and Ruby installed).

### Clone the repo

  git clone git@github.com:theodi/uk-postcodes.git
  
### Run bundler
  
  bundle install
  
### Import the data

  rake import:all

(This will take a good 40 minutes to an hour, so go outside and play, or something)

### Run the app

  rails s
  
Obviously if you're running this in production, you may need to do some other steps, but these steps should be all you need to get it running locally.


