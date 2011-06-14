# coding: utf-8

ActionView::Helpers::NumberHelper.module_eval do
  def number_to_currency_with_synergy(number, options = {})
    number_to_currency_without_synergy(number, options).gsub(' ', "\302\240")
  end
  alias_method_chain :number_to_currency, :synergy
end