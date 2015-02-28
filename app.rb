require 'sinatra/base'
require 'sinatra/assetpack'

module Generators; end
require_relative 'generators/regular'
require_relative 'generators/ekivoki'

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

  get '/gen-card/cover' do
    send_file 'public/reg_cover.pdf', filename: 'reg-card-cover.pdf'
  end

  get '/equi-card/cover' do
    send_file 'public/equi-cover.pdf', filename: 'equi-card-cover.pdf'
  end

  post '/gen-card' do
    content_type 'application/pdf'
    pdf = ::Generators::Regular.new(params)
    pdf.render
  end

  post '/equi-card' do
    content_type 'application/pdf'
    pdf = ::Generators::Ekivoki.new(params)
    pdf.render
  end
end
