 class Api::V1::AuthController < ApplicationController

##asjdoa
    def login 
        
        user = User.find_by(email_address: params[:email_address])
        
        if user && user.authenticate(params[:password])
            
            render json:  user
        else 
            render json:{errors: "invalid username/ password"}
            
        end 

    end 


end