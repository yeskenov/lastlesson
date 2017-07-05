class UsersController < ApplicationController
    before_action :require_user, only: [:show,:edit,:destroy]

    
    def index
        @users = User.paginate(page: params[:page], per_page: 5)
    end
    
    def show
        @user = User.find(params[:id])
        @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
    end
    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            flash[:success] = "Signed in"
            redirect_to user_path(@user)
        else
            render "new"
        end
    end
    def edit
        @user = User.find(params[:id])
        require_same_user
    end
    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            flash[:success] = "Updated!"
            redirect_to user_path(@user)
        else
            render "edit"
        end
    end
    def new
        @user = User.new
    end
    def destroy
        @user = User.find(params[:id])
        require_same_user
        @user.destroy
        flash[:success] = "User deleted"
    end
    private
    def user_params
        params.require(:user).permit(:username, :email,:password)
    end
    def require_same_user
        if logged_in? current_user != @user 
            flash[:danger] = "Only admin can perform this action"
            redirect_to users_path
        end
    end
   
end