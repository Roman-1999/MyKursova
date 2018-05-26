class RepositoriesController < ApplicationController
  before_action :set_repository, only: [:show, :edit, :update, :destroy]

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def test
    require 'net/http'
    require 'uri'
    #org_url = "https://api.github.com/organizations?since=39634367"
    org_url = "https://api.github.com/organizations?since=100000"
    org_uri = URI.parse(org_url)
    response_o = Net::HTTP.get_response(org_uri)
    @org = JSON.parse(response_o.body)
    @repos = {}
    @org.each do |rp|
      @repos[rp['id']] = JSON.parse(Net::HTTP.get_response(URI.parse(rp['repos_url'])).body)
    end

    ##Створюємо діаграму по даним
    #@lang = {}
    #@org.each do |org|
      #@repos[org['id']].each do |rp|
        #if @lang[rp['language']].present?
          #@lang[rp['language']] = @lang[rp['language']]+1
       #else
          #@lang[rp['language']] = 1
        #end
      #end
    #end
  end

  def create
    pp@org=Org.create(org_params)
    pp@org.save
    pp@org_git = @org.repositories.build(rep_params)
    pp@org_git.save
  end

  def update
  end

  def destroy
  end

  private

  def set_repository
    @repository = Repository.find(params[:id])
  end

  def repository_params
    params.require(:repository).permit(:name, :description, :url)
  end
end