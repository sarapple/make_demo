class DemonstrationsController < ApplicationController
  def index
  end

  def doc

  end

  def inputted
  	if params[:input][0..3] != 'Make'
    	render json:{ :to_append=>"Syntax Error" }   
    else
    	@result = eval(params[:input])
    	render json:{ :to_append=>@result }
    end
  end
end
