class ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :edit, :delete, :update]
    before_action :require_user, except: [:index,:show]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    def show
  
    end
  
    def index
      @articles = Article.paginate(page: params[:page], per_page: 5)
    end
  
    def new
      @article = Article.new
    end
  
    def edit
  
    end
  
    def create
      @article = Article.new(article_params)
      @article.user = current_user
      if @article.save
        flash[:notice] = "Article was created successfully."
        redirect_to @article
      else
        render 'new', status: :unprocessable_entity
      end
    end
  
    def update
      if @article.update(article_params)
       flash[:notice] = "Article was updated successfully"
       redirect_to @article
      else
        render'edit'
  
      end
  
    end
  
    def delete 
      @article.destroy
      redirect_to articles_path
    end
  
    private
  
    def set_article
      id = params[:article_id] || params[:id]
       @article = Article.find(id)
    end
  
    def article_params
      params.require(:article).permit(:title, :description, category_ids: [])
      
    end
    
    def require_same_user
      if current_user != @article.user && !current_user.admin?
        flash[:alert] = "You can only edit or delete your own article"
        redirect_to @article
      end
     end

  end






