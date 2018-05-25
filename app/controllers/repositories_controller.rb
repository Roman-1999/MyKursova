class RepositoriesController < ApplicationController
  before_action :set_repository, only: [:show, :edit, :update, :destroy]

  def index
    @repositories = Repository.all
  end

  def show
  end

  def new
    @repository = Repository.new
  end

  def edit
  end

  def test
    require 'net/http'
    require 'uri'
    #url = "https://api.github.com/search/repositories?q=programing&per_page=100"
    org_url = "https://api.github.com/organizations?since=0"
    ######rep_org_url = "https://api.github.com/orgs/errfree/repos"
    #uri = URI.parse(url)
    org_uri = URI.parse(org_url)
    ######rep_org_uri = URI.parse(rep_org_url)
    #response = Net::HTTP.get_response(uri)
    ######response_p = Net::HTTP.get_response(rep_org_uri)#репозиторії організації
    #@resp = JSON.parse(response.body)
    response_o = Net::HTTP.get_response(org_uri)
    @org = JSON.parse(response_o.body)
    ######@org_resp = JSON.parse(response_p.body)
    @repos = {}
    @org.each do |rp|
      @repos[rp['id']] = JSON.parse(Net::HTTP.get_response(URI.parse(rp['repos_url'])).body)
    end

    ##Створюємо діаграму по даним
    @lang = {}
    @org.each do |org|
      @repos[org['id']].each do |rp|
        if @lang.has_key(rp['language'])
          @lang[rp['language']] = @lang[rp['language']]+1
        else
          @lang[rp['language']] =1
        end
      end
    end
  end

  def create
    @repository = current_user.repositories.build(repository_params)

    repo = @repository.search_on_github(
             current_user.username, params[:name]
           )

    if repo
      @repository = current_user.repositories.build(
                      name: repo[:name],
                      description: repo[:description],
                      url: repo[:html_url]
                    )
      @repository.save!

      redirect_to @repository, notice: 'Repository was successfully created.'
    else
      redirect_to root_path, alert: 'Repo not found!'
    end
  end

  def update
    respond_to do |format|
      if @repository.update(repository_params)
        format.html { redirect_to @repository, notice: 'Repository was successfully updated.' }
        format.json { render :show, status: :ok, location: @repository }
      else
        format.html { render :edit }
        format.json { render json: @repository.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @repository.destroy
    respond_to do |format|
      format.html { redirect_to repositories_url, notice: 'Repository was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_repository
    @repository = Repository.find(params[:id])
  end

  def repository_params
    params.require(:repository).permit(:name, :description, :url)
  end
end