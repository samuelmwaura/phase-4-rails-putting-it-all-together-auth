class SessionsController < ApplicationController
    
    #POST /login
    def create
        user = User.find_by(username:params[:username])
        if user&.authenticate(params[:password]) #if a user by the username exists and the password supplied is the same as the one stored decrypted
            session[:user_id] = user.id
            render json:user, status: :created
        else
            render json: {errors:["invalid username or password"]}, status: :unauthorized
        end
    end
    
    #DELETE /logout
    def destroy
    if session.include? :user_id #There is currently a user logged in
        session.delete :user_id #Log them out
        head :no_content #Send a no reponse content response
    else
        render json: {errors:["You are currently not logged in!"]}, status: :unauthorized
    end
    end


end
