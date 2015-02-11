class TestersController < ApplicationController
	def tester
		render 'tester'
	end
	def inputted
		if params[:input][0..3] != 'Make'
			render json:{ :to_append=>"Syntax Error" }   
		else
			@result = eval(params[:input])
			render json:{ :to_append=>@result }
		end
	end
	def states
		State.create (state_params)
		redirect_to '/demonstrations/tester'
	end
	def users
		User.create (user_params)
		redirect_to '/demonstrations/tester'
	end
	def blogs
		Blog.create (blog_params)
		redirect_to '/demonstrations/tester'
	end
	def user_params
		params.require(:user).permit(:email, :first_name, :middle_name, :last_name, :password, :password_confirmation, :state_id)
	end
	def state_params
		params.require(:state).permit(:name)
	end
	def blog_params
		params.require(:blog).permit(:title, :user_id)
	end
end
