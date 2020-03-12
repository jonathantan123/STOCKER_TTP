class FindController < ApplicationController




    def find 

       portfolio =  Portfolio.find_by(user_id: params[:id])
       portfolioStocks = portfolio.stocks 

       portfolioStocks.map do |stock| 
    
        url = "https://cloud.iexapis.com/stable/stock/#{stock.ticker}/quote?token=#{Rails.application.credentials[:apiKey]}&filter=open,close,latestPrice,previousClose,iexRealtimePrice"

        response = HTTParty.get("#{url}")
        

        json = JSON.parse response.body
        
        
        
         stock.price = json['latestPrice'].to_f().round(2)
         stock.total = stock.price * stock.quantity
       
            
           comparisionPrice =  json["open"] ? "open" : "previousClose"
           

            if (stock.price > json[comparisionPrice].to_f()) 
                stock.color = "green"
            elsif (json["latestPrice"].to_f() < json[comparisionPrice].to_f())
                stock.color = "red"
            else 
                stock.color = "grey" 
            end 


        end 


        render json: portfolioStocks
        
       

    end 


end
 