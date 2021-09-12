# frozen_string_literal: true

class UsersController < ApplicationController

	def typeahead
    search_key = params[:term]&.split("")
    result = []
    search_key.each do |key|
		  result << User.where('first_name like ?', "%#{key}%").or(User.where('last_name like ?', "%#{key}%").or(User.where('email like ?', "%#{key}%")))
		end
    result.compact!
    res = result.reject { |c| c.empty? }
    res.flatten!
    render json: res.uniq
	end

	def index
		@user = User.order('created_at DESC').page(params[:page])
		render json: @user
	end

	def show
		@user = User.find_by(id: params[:id])
    if @user
      render json: @user
    else  
      message = "No record was found for id #{params[:id]}."
      render  json: { error: message }, status: :not_found
    end
	end

	def create
		@user = User.create!(user_params)
		render json: @user, status: :created
	end

	def update
		@user = User.find_by(id: params[:id])
		if @user
      @user.update(user_params)
  		render json: @user, status: :updated
    else
      message = "No record was found for id #{params[:id]}."
      render  json: { error: message }, status: :not_found
    end
	end


	def delete
		@user = User.find_by(id: params[:id])
		if @user
      @user.delete 
  		render json: {}
    else
      message = "No record was found for id #{params[:id]}."
      render  json: { error: message }, status: :not_found
    end
	end

	private

	def user_params
		params.permit(:first_name, :last_name, :email)
	end
end
