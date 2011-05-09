Spree::BaseController.class_eval do       
  def render_404(exception = nil)
    @title = I18n.t(:page_not_found)
    render :template => 'errors/404', :status => "404 Not Found"
  end
end
