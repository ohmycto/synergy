class Admin::SynergySettingsController < Admin::BaseController
  def update
    contacts_preferences = params[:preferences][:contacts]
    
    Spree::Config.set(contacts_preferences)
    
    respond_to do |format|
      format.html { redirect_to admin_synergy_settings_url }
    end
  end
end