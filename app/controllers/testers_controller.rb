class TestersController < ApplicationController
	def index
		@stateForm = Make.form.model('State').now!
		@stateTable = Make.table.model('State').now!
		@userForm = Make.form.model('User').select('state_id', (1..5).select, assoc=true).now!
		@userTable = Make.table.model('User').now!
		@blogForm = Make.form.model('Blog').select('user_id', (1..4).select, assoc=true).now!
		@blogTable = Make.table.model('Blog').now!
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
		redirect_to '/testers/index'
	end
	def users
		User.create (user_params)
		redirect_to '/testers/index'
	end
	def blogs
		Blog.create (blog_params)
		redirect_to '/testers/index'
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
