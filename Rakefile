require './app'
require 'sinatra/activerecord/rake'

namespace :assets do
  task :compile do
    `compass compile sass/application.scss --css-dir=public/stylesheets`
  end
end