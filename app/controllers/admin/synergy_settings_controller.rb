class Admin::SynergySettingsController < Admin::BaseController
  before_filter :load_configuration, :only => [:edit, :update]
  
  def show
    @synergy_configuration = Spree::Synergy::Config.get
  end
  
  def update
    contacts_preferences = params[:preferences][:contacts]    
    Spree::Config.set(contacts_preferences)

    if @synergy_configuration.update_attributes(params[:synergy_configuration])
      Spree::Synergy::Config.set
      redirect_to admin_synergy_settings_url
    else
      render 'edit'
    end
  end
  
  private
  
  def load_configuration
    @synergy_configuration = Spree::Synergy::Config.instance
  end
end