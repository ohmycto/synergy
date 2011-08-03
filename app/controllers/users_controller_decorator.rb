UsersController.class_eval do
  before_filter :check_juridical, :only => :update
  
  def check_juridical
    current_user.juridical = false unless params[:user][:juridical]
  end
end