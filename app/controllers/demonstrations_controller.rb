class DemonstrationsController < ApplicationController
    def index
        #set defaults for chain inputs
        @message=''
        session[:formChain] = ['action', 'class', 'default', 'method', 'select', 'no_pw_confirm', 'hide', 'assoc']
        session[:chainable]=['th','order','cut','limit','combo','show']
        session[:tree]={'Make'=>['custom','table']}
        session[:custom]=false
        session[:form]=false
        session[:color]='green'
    end
    def find
        @to_send=[]
        @code=''
        @workable=false
        case params[:method]
        when 'table'
            @to_send=['model','custom']
            session[:form] = false
        when 'custom'
            session[:custom]=true
            @to_send=['th']
            @code="5,8"
        when 'model'
            if session[:form]   # <-- Portion added to UL's code for form section 
                @to_send=session[:formChain]+['now!'] # <-- Portion added to UL's code for form section  
            else 
                @to_send=session[:chainable]+['file','for!','now!']
            end
            session[:form] = false
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

        # Portion added to UL's demo code for form section, by Sara --->
        when 'form'
            session[:color] = 'pink'
            @to_send=['model']
            session[:form] = true
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
            session[:formChain].delete('assoc')    
            @to_send=session[:formChain] + ['now!']
            @code="'state_id', (1..5).select"
        when 'assoc'
            session[:formChain].delete('select')  
            session[:formChain].delete('assoc')      
            @to_send=session[:formChain] + ['now!']
            @code="'state_id', 'name'"
        when 'no_pw_confirm'
            session[:formChain].delete('no_pw_confirm')    
            @to_send=session[:formChain] + ['now!']
        when 'hide'
            session[:formChain].delete('hide')    
            @to_send=session[:formChain] + ['now!']
            @code="['first_name', 'last_name', 'middle_name']"
        # <--- Portion added to UL's demo code for form section, by Sara      

        else
        # puts 'what'
            @workable=true
        end
        render json:{:to_append=>@to_send,:code=>@code,:workable=>@workable,:color=>session[:color]}
    end
    def clear
        # @message=''
        session[:formChain] = ['action', 'class', 'default', 'method', 'select', 'no_pw_confirm', 'hide', 'assoc']
        session[:tree]={'Make'=>['custom','table']}
        session[:form]=false
        @to_send=[]
        @workable=false
        session[:color]='green'
        session[:custom]=false
        session[:chainable]=['th','order','cut','limit','combo','show']
        render json:{:to_append=>'CLEAR'}
    end
    def run
        params[:run_code]=params[:run_code].gsub('=&gt;','=>')
        @message=eval("Make"+params[:run_code])
        @string = @message.to_s
        render json:{:to_append=>@message }
    end
    def formsubmit
        @message='Form submittal is not allowed'
        render json:{:to_append=>@message }
    end
end
