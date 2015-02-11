class DemonstrationsController < ApplicationController
  def index
    @message=''
    session[:formChain] = ['action', 'class', 'default', 'method', 'select', 'no_pw_confirm']
    session[:chainable]=['th','order','cut','limit','combo','show']
    session[:tree]={'Make'=>['custom','table']}
    session[:custom]=false
    session[:form]=false
  end
  def find
    @to_send=[]
    @code=''
    @workable=false
    @color='green'

    # Will color the 'CHILDREN' of the array members
    if ['custom','for!'].include? params[:method]
      @color='pink'
    end
    if 'model' == params[:method] && @form
      @color='pink'
    end
    case params[:method]
      when 'table'
        @to_send=['model','custom']
        @form = false
      when 'custom'
        session[:custom]=true
        @to_send=['th']
        @code="5,15"
      when 'model'
        # Portion added to UL's code for form section -->
        if session[:form]
          @to_send=session[:formChain]
        # <-- Portion added to UL's code for form section
        else 
          @to_send=session[:chainable]+['file','for!','now!']
        end
          @code="'User'"
      when 'th','order','cut','limit','combo','show'
        if session[:custom]
          @to_send=['file']
          @code="'First','Second','Third','Fourth','Fifth'"
        else
          session[:chainable].delete(params[:method])
          @to_send=session[:chainable]+['file','for!','now!']
          @code={'order'=>"'first_name ASC'",'cut'=>"'email'",'limit'=>"4",'combo'=>"{'Full Name'=&gt;['first_name','middle_name','last_name']}",'show'=>"'id'"}[params[:method]]
        end
      when 'file'
        if !session[:custom]
          @to_send=['now!']
        end
        @workable=true

      


      # Portion added to UL's demo code for form section, by Sara
      when 'form'
        @to_send=['model']
        session[:form] = true;
      when 'action'
        session[:formChain].delete('action')
        @to_send=session[:formChain] + ['now!']
        @code="'/myController/myMethod'"
      when 'method'
        session[:formChain].delete('method')    
        @to_send=session[:formChain] + ['now!']
        @code="'put', 2"
       when 'class'
        session[:formChain].delete('class')    
        @to_send=session[:formChain] + ['now!'] 
        @code="'my-class'"
       when 'default'
        session[:formChain].delete('default')    
        @to_send=session[:formChain] + ['now!']
        @code="'state_id', 3"
       when 'select'
        session[:formChain].delete('select')    
        @to_send=session[:formChain] + ['now!']
        @code="'state_id', (1..5).select, assoc=true"
       when 'no_pw_confirm'
        session[:formChain].delete('no_pw_confirm')    
        @to_send=session[:formChain] + ['now!']
        



        else
        # puts 'what'
        @workable=true
    end
    render json:{:to_append=>@to_send,:code=>@code,:workable=>@workable,:color=>@color}
  end
  def clear
    session[:custom]=false
    session[:chainable]=['th','order','cut','limit','combo','show']
    render json:{:to_append=>'CLEAR'}
  end
  def run
    params[:run_code]=params[:run_code].gsub('=&gt;','=>')
    @message=eval("Make"+params[:run_code])
    render json:{:to_append=>@message}
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
  def tester
    puts 'hi'
  end
end
