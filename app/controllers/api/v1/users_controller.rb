class Api::V1::UsersController < ApplicationController

	def create 
		user = User.create(user_params)
		if user and user.save
		  render :json => {user: JSONAPI::Serializer.serialize(user), :message => 'User created successfully'}, :status => 200
		else
		  render :json => { :message => 'Email already exists'}, :status => 406
		end
	end

	def login 
		user = User.find_by(email: user_params[:email])
		if user.present? and user.valid_password?(user_params[:password])
		  render :json => {user: JSONAPI::Serializer.serialize(user), :message => 'Login successfully'}, :status => 200
		else
		  render :json => { :message => 'Invalid Credentials'}, :status => 406
		end
	end


	def remove_friend 
		user = User.find_by(id: params[:id])
		friend = User.find_by(email: params[:friend_email])
		if friend.present? 
		  if user.friends.include? friend
		  	user.friends.delete(friend)
		   render :json => {user: JSONAPI::Serializer.serialize(user), :message => 'friend removed successfully'}, :status => 200
		  else
		    render :json => { :message => 'friend does not exists'}, :status => 404 
		  end
		else
		  render :json => { :message => 'User does not exist'}, :status => 404
		end
	end

	def add_friend
		user = User.find_by(id: params[:id])
		friend = User.find_by(email: params[:friend_email])
		if friend.present? 
		  if user.friends.include? friend
		    render :json => { :message => 'friend already exists'}, :status => 404 
		  else
		    user.friends.push(friend)
		    user.save
		    render :json => {user: JSONAPI::Serializer.serialize(user), :message => 'friend added successfully'}, :status => 200
		  end
		else
		  render :json => { :message => 'User does not exist'}, :status => 404
		end
	end

	private

	def user_params
		params.require(:user).require(:data).require(:attributes).permit(:fname, :lname, :email, :password)
	end
end
