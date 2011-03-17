fields = {
   product_available_on: "Укажите начиная с какой даты товар станет<br /> доступен в публичной части магазина",
   product_permalink: "Постоянная ссылка на товар (SEO-аттрибут)"
   
}

function register_help() {
  jQuery.each(fields, function(element_id, help_msg) {
    jQuery('label[for='+element_id+']').after("&nbsp;<span class='help' id='help_"+element_id+"'><img src='/images/admin/icons/help.png' alt='help' /></span>");
    jQuery('#help_'+element_id).simpletip({ position: 'right', offset: [-10, -230], content: help_msg});
  });
}

$(document).ajaxSuccess(register_help);
$(document).ready(register_help);

