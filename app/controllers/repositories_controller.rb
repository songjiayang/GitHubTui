class RepositoriesController < ApplicationController
  before_action :load_resource, except: [:index]

  def index
    case params[:c]
    when "like"
      @items = Repository.liked
    when "all"
      @items = Repository.all
    else
      @items = Repository.unprocessed
    end

    @items = @items.with_language(params[:l]) unless params[:l].nil?

    case params[:s]
    when "star"
      @items = @items.page(params[:page]).per(20).moststar
    else
      @items = @items.page(params[:page]).per(20).latest
    end
  end

  def show
    @repository = Repository.first unless @repository
  end

  def like
    @repository.liked!
    redirect_to @repository
  end

  def dislike
    @repository.disliked!
    redirect_to Repository.find(@repository.id + 1)
  end

  private

  def load_resource
    @repository = Repository.find_by(id: params[:id])
  end
end
