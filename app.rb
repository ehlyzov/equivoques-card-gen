require 'sinatra/base'
require 'sinatra/assetpack'

module Generators; end
require_relative 'generators/regular'

class App < Sinatra::Base
  
  register Sinatra::AssetPack
  assets do
    serve '/js', from: 'js'
    serve '/bower_components', from: 'bower_components'
    
    js :modernizr, [
      '/bower_components/modernizr/modernizr.js',
    ]
    
    js :libs, [
      '/bower_components/jquery/dist/jquery.js',
      '/bower_components/foundation/js/foundation.js'
    ]
    
    js :application, [
      '/js/app.js'
    ]
    
    js_compression :jsmin
  end

  get '/' do
    erb :index
  end

  post '/gen-card' do
    content_type 'application/pdf'
    pdf = ::Generators::Regular.new(params)
    pdf.render
  end    
end
