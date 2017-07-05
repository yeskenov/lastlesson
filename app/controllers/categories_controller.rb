class CategoriesController < ApplicationController
    
    def index
        @categories = Category.all
    end
    
    def show
        @category = Category.find(params[:id])
    end
    
    def new
        @category = Category.new
    end
    
    def destroy
    end
    
    def create
        @category = Category.new(category_params)
        if @category.save
            flash[:success] = "Category created"
            redirect_to categories_path
        else
            render "new"
        end
    end
    
    def edit
         @category = Category.find(params[:id])
    end
    
    def update
        @category = Category.find(params[:id])
        if @category.update(category_params)
            flash[:success] = "Updated"
            redirect_to category_path(@category)
        else
            render 'edit'
        end
    end
    private
    
    def category_params
        params.require(:category).permit(:name)
    end
    
end