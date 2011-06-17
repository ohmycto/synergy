# coding: utf-8
Admin::BaseController.class_eval do
  def flash_message_for(object, event_sym)
    resource_i18n_class_name = object.class.model_name.human.mb_chars
    resource_desc = resource_i18n_class_name
    resource_desc += " \"#{object.name}\"" if object.respond_to?(:name)
    
    if (resource_i18n_class_name =~ /[ое](\s|$)/)
      I18n.t("it_#{event_sym}", :resource => resource_desc)
    elsif (resource_i18n_class_name =~ /[ая](\s|$)/)
      I18n.t("she_#{event_sym}", :resource => resource_desc)
    else
      I18n.t(event_sym, :resource => resource_desc)
    end
  end
end
