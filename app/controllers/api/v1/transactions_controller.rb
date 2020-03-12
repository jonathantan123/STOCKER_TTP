class Api::V1::TransactionsController < ApplicationController


    def index 
        trans = Transaction.all
        render json: trans

    end 


    def create 
        ## first find the stock  
    
        user = User.find(params[:user_id])
     
        
        query = params[:ticker].capitalize() 
        url = "https://cloud.iexapis.com/stable/stock/#{query}/quote?token=#{Rails.application.credentials[:apiKey]}&filter=companyName,symbol,latestPrice,previousClose"
        response = HTTParty.get("#{url}")

        

        if (response.body === "Unknown symbol") 
            render json: {error: "Invalid Ticker"}
        else 

            json = JSON.parse response.body
            userBalance = user.balance.to_f.round(2)
            ticker = json["symbol"]
            latestPrice = json["latestPrice"].to_f().round(2)
            totalCost = latestPrice * params[:quantity].to_i()
            
   
            
            if(totalCost > userBalance )  
                render json: {error: "you dont have enough funds "}
            else   
                portfolio = user.portfolio
                portfolioStocks = portfolio.stocks
                
          
                foundStock = portfolioStocks.find{ |stock| stock.ticker === ticker} 

                if (foundStock)
                    foundStock.quantity += params[:quantity].to_i()
                    foundStock.price = latestPrice
                 else  
                    newStock = Stock.create(ticker: "#{json["symbol"]}", price: "#{json["latestPrice"]}", quantity: params[:quantity].to_i(), color: "gray")
                    portfolioStocks.push(newStock)
                 end 

                  portfolio.update(stocks: portfolioStocks)
            
                  user.update(balance: user.balance - totalCost )
               
                  newTransaction = user.transactions.create(ticker: "#{json["symbol"]}", quantity: params[:quantity].to_i, price: "#{json["latestPrice"]}")

                 render json: {message: "Purchased!", balance: user.balance }

                
            end
    end  

end 
end 

