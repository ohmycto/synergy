fields = {
   product_available_on: "Укажите, начиная с какой даты товар станет<br />доступен в публичной части магазина.",
   product_permalink: "Постоянная ссылка на товар (SEO-атрибут).",
   product_prototype_id: "Заранее определенный набор свойств товара.<br />Позволяет существенно сэкономить время при<br />добавлении товаров с одинаковыми наборами свойств.<br />Прототипы задаются в меню \"Товары\"&nbsp;&ndash;&nbsp;\"Прототипы\"",
   product_price: "Дробная часть отделяется точкой.",
   product_shipping_category_id: "Набор способов доставки, применимых к данному товару.<br />Определяется в меню \"Конфигурация\"&nbsp;&ndash;<br />\"Способы доставки\"/\"Категории доставки\"",
   product_tax_category_id: "Набор налоговых ставок, применимых к данному товару.<br />Определяется в меню \"Конфигурация\"&nbsp;&ndash;<br />\"Налоговые ставки\"/\"Категории налогов\"",
   option_type_name: "Для внутреннего использования в административном интерфейсе.",
   option_type_presentation: "Для отображения в магазине.",
   property_name: "Для внутреннего использования в административном интерфейсе.",
   property_presentation: "Для отображения в магазине.",
   prototype_name: "Для внутреннего использования в административном интерфейсе.<br />Старайтесь, чтобы название прототипа отражало товар, к которому<br />он будет применяться."
}

function register_help() {
  jQuery.each(fields, function(element_id, help_msg) {
    jQuery('label[for='+element_id+']').after("&nbsp;<span class='help' id='help_"+element_id+"'><img src='/images/admin/icons/help.png' alt='help' /></span>");
    jQuery('#help_'+element_id).simpletip({ position: 'right', offset: [-10, -230], content: help_msg});
  });
}

$(document).ajaxSuccess(register_help);
$(document).ready(register_help);

