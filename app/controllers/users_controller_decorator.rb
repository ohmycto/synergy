UsersController.class_eval do
  prepend_before_filter :load_object, :only => [:show, :edit, :update, :edit_status, :update_status]
  before_filter :check_juridical, :only => :update_status
  
  def check_juridical
    current_user.juridical = false unless params[:user][:juridical]
  end
  
  def update_status
    if @user.update_attributes(params[:user])
      flash.notice = I18n.t(:account_updated)
      redirect_to account_url
    else
      render 'edit_status'
    end
  end
end