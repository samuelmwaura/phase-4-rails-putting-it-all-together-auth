class UsersController < ApplicationController

    #POST /signup
    def create
      user = User.create(user_params) #You cannot use the bang operator with the below valid boolean requestor since the exception willl throw earlier
      if user.valid? #This is mainly to handle the invalid error raised by has_secure_password of password not matching
        session[:user_id] = user.id
        render json: user, status: :created
      else
         render json:{errors:user.errors.full_messages},status: :unprocessable_entity #The user.errors.full_messages only works to return the errors that are returned attached to the user model.
      end
    end


    def show
        if session.include? :user_id
            user = User.find(session[:user_id])        
            render json: user, status: :created
        else
            render json: {error:"You are not logged in!"},status: :unauthorized
        end
    end
    

    private
    def user_params
        params.permit(:username,:password,:password_confirmation,:image_url,:bio) #The password confirmation has to be listed explicitly inorder to deal with the
        #functionality of checking whether the passed in passwords match.
    end
end
