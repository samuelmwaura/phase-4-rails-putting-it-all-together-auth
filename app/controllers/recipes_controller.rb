class RecipesController < ApplicationController
    before_action :authorize
    rescue_from ActiveRecord::RecordInvalid, with: :render_record_not_valid
    
    #GET /recipes
    def index
        recipes = Recipe.all
        render json: recipes, status: :created
    end
    
    #POST /recipes
    def create
      user = User.find(session[:user_id])
      recipe = user.recipes.create!(recipe_params) #Will create a recipe that is owned by the current user
      render json: recipe, status: :created
    end

    private
    def authorize
      render json: {errors:["You must be logged in first!"]}, status: :unauthorized  unless session.include? :user_id 
    end

    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete)
    end

    def render_record_not_valid(exception) #Exception is raised by any invalid attributes and has its errors added to the array of errors.
        render json: {errors:exception.record.errors.full_messages}, status: :unprocessable_entity
    end
end
