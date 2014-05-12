module Scoreboard
  class App < Padrino::Application
    register CompassInitializer
    register Padrino::Rendering
    register Padrino::Helpers
    include Sinatra::HasScope
    use ActiveRecord::ConnectionAdapters::ConnectionManagement

    enable :sessions
    enable :flash

    layout :application


    before do
      has_scope :memberships, :unique, type: :boolean
      @admin = !session[:user].nil? || settings.environment == :development
    end

    get :index do
      @semester = Semester.current_semester
      @members = Member.high_score(@semester)
      render 'home/index'
    end

    after do
      ActiveRecord::Base.connection.close
    end

    def self.authorize(authorized)
      condition do
        halt 403, 'Not authorized' unless @admin
      end if authorized
    end

    error 403 do
      render('errors/403')
    end

    error 404 do
      render('errors/404')
    end

    error 500 do
      render('errors/500')
    end

  end
end