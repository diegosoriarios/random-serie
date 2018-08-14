class HomeController < ApplicationController
  before_action :authenticate_user!
  require 'httparty'

  def index
    filmes = HTTParty.get('http://www.hot2z.com/api/v1.0/absl15/?')

    x = rand(filmes.length)
    session[:titulo] = filmes[x]["title"]
    for i in 1..9
      if session[:titulo].include? " - S0" + i.to_s
        session[:titulo] = session[:titulo].split(' - S0' + i.to_s).join
      end
    end
    session[:ano] = filmes[x]["release"]
    session[:sinopse] = filmes[x]["story"]
    if session[:sinopse].include? "See full summary"
      session[:sinopse] = session[:sinopse].split('See full summary').join
    end
    session[:vermais] = 'https://www.imdb.com/title/' + filmes[x]["imdbid"].to_s
    session[:rating] = filmes[x]["rating"].to_s + '/10'
    session[:poster] = 'http://' + filmes[x]["poster"]
  end

  def new
    @movie = Movie.new(title: session[:titulo], ano: session[:ano], sinopse: session[:sinopse], image: session[:poster], nota: session[:rating], vermais: session[:vermais], user_id: current_user.id)

    @movie.save
    redirect_to root_path
  end

  def show
    @movies = Movie.all
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy

    redirect_to home_path('likes')
  end
end
