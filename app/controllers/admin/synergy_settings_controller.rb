class Admin::SynergySettingsController < Admin::BaseController
  def show
    @preferences = Spree::Synergy::Config.get
  end

  def edit
    @preferences = Spree::Synergy::Config.get
  end
  
  def update
    preferences = params[:preferences]
    
    enable_juridical = preferences[:juridical_enabled].nil? ? false : true
    enable_nds = preferences[:nds].nil? ? false : true
    preferences.update(:juridical_enabled => enable_juridical, :nds => enable_nds)    
    Spree::Synergy::Config.set(preferences)

    contacts_preferences = params[:preferences][:contacts]    
    Spree::Config.set(contacts_preferences)
    
    respond_to do |format|
      format.html { redirect_to admin_synergy_settings_url }
    end
  end
end
