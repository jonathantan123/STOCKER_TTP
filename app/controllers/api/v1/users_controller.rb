class Api::V1::UsersController < ApplicationController

    
    # def index 
    #     users = User.all
    #     render json: users
        
    # end 


    def show 
        user = User.find(params[:id])
        
        transactions = user.transactions
        portfolioStocks = user.portfolio.stocks

        render json: {transactions: transactions}
    end 


    def create 
        
        user = User.new(
            email_address: params[:email_address],
            password: params[:password], 
            name: params[:name], 
            )
        
        if user.save 
            Portfolio.create(user_id: user.id)
            render json: user 
        else 
            render json: {errors: user.errors.full_messages}
        
    end 
end 



end 
