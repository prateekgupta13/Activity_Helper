class MessagesController < ApplicationController
	respond_to :html,:xml,:json
	before_filter :signed_in_user, only: [:create,:index,:destroy,:conversation]
    def new
    	@message=Message.new
    end

	def create  
		if params[:recipient_id] 
			@friend_id=params[:recipient_id]
     		@message=current_user.messages.build(message: params[:message][:message], recipient_id: @friend_id) 
     	else		
			str=params[:message][:message]
			message=str.gsub(str.scan(/@\w+/).last, "")
			@friend_id=(User.find_by_username(str.scan(/\w+/).last)).id
			if @friend_id!=current_user.id
			@message=current_user.messages.build(message: message, recipient_id: @friend_id) 		
			end
   		end
	    if(@message.save)
	    	messages=current_user.messages.where(recipient_id:@friend_id)
			inverse_messages=current_user.inverse_messages.where(user_id:@friend_id)
			@messages_all=messages+inverse_messages
	    	respond_with do |format|
        		format.html do
          			if request.xhr?
            			render partial:'messages/conversation', layout:false, status: :created, locals: {messages_all: @messages_all, friend_id: @friend_id}
          			end
       			end
      		end  
	    else 
	    end
	end
		
	def index
		@friend_id=params[:recipient_id]
		@messages = current_user.messages.where("recipient_id = ? and created_at > ?", params[:recipient_id], Time.zone.at(params[:after].to_i+1))		
		@inverse_messages = current_user.inverse_messages.where("user_id = ? and created_at > ?", params[:recipient_id], Time.at(params[:after].to_i+1))		
		@messages_all=@messages+@inverse_messages



		# current_user.messages.each do|message|
		# @friend_id=params[:param1]
		# @friend=User.find(@friend_id)
		# messages=current_user.messages.where(recipient_id:@friend_id)
		# inverse_messages=current_user.inverse_messages.where(user_id:@friend_id)
		# @messages_all=messages+inverse_messages
	end

	def show
		# @message=Message.find(params[:id]);
	end

	def conversation
		@friend_id=params[:param1]
		@friend=User.find(@friend_id)
		messages=current_user.messages.where(recipient_id:@friend_id)
		inverse_messages=current_user.inverse_messages.where(user_id:@friend_id)
		@messages_all=messages+inverse_messages
		inverse_messages.update_all status:true
		respond_with do |format|
          	format.js
          	format.html
       	end	 	
    end      

    def destroy
    	message_id=Message.find_by_id(params[:id])
    	if Message.destroy(message_id)
	    	@friend_id=params[:friend_id]
			messages=current_user.messages.where(recipient_id:@friend_id)
			inverse_messages=current_user.inverse_messages.where(user_id:@friend_id)
			@messages_all=messages+inverse_messages
    		respond_with do |format|
         	 	format.js 
          		format.html
       		end	 	
       	end
    end

    def get_friends

    	friends=[]
    	par="#{params[:q]}"
    	par1=par.scan(/\w+/).last
    	all=User.where("username LIKE ?", "#{par1}%")
    	all.each {|friend| 
    		if(current_user.friendships.find_by_friend_id(friend.id)||current_user.inverse_friendships.find_by_user_id(friend.id))
    		username=friend.username
    		n=par+username
    		m=n.gsub(n.scan(/@[a-z]+/).last, "@")
    		img= "http://www.gravatar.com/avatar/" + friend.email
    		# (par+username).gsub()
    		friends << {value:m, text:username,img:img }
    		end
    	
		}
    	render json: friends
    end
end
