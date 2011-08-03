# -*- encoding: utf-8 -*- 
$KCODE = 'u' if RUBY_VERSION < '1.9.0'

# Самый лучший, прекрасный, кривой и неотразимый суперпечататель суммы прописью для Ruby.
#
#   RuPropisju.rublej(123) # "сто двадцать три рубля"
module RuPropisju
  
  VERSION = '1.1.0'
  
  # Выбирает нужный падеж существительного в зависимости от числа
  #
  #   choose_plural(3, "штука", "штуки", "штук") #=> "штуки"
  def choose_plural(amount, *variants)
    mod_ten = amount % 10
    mod_hundred = amount % 100
    variant = if (mod_ten == 1 && mod_hundred != 11) 
        1
    else
      if mod_ten >= 2 && mod_ten <= 4 && (mod_hundred <10 || mod_hundred % 100>=20)
        2
      else
        3
      end
    end
    variants[variant-1]
  end
  
  
  # Выводит целое или дробное число как сумму в рублях прописью
  #
  #   rublej(345.2) #=> "триста сорок пять рублей 20 копеек"
  def rublej(amount)
    pts = []
    
    pts << propisju_shtuk(amount.to_i, 1, "рубль", "рубля", "рублей") unless amount.to_i == 0
    
    if amount.kind_of?(Float)
      remainder = (amount.divmod(1)[1]*100).round
      if (remainder == 100)
        pts = [propisju_shtuk(amount.to_i+1, 1, 'рубль', 'рубля', 'рублей')]
      else
        kop = remainder.to_i
        unless kop.zero?
          pts << kop << choose_plural(kop, 'копейка', 'копейки', 'копеек')
        end
      end
    end
    
    pts.join(' ')
  end
  
  # Выбирает корректный вариант числительного в зависимости от рода и числа и оформляет сумму прописью
  #
  #   propisju(243) => "двести сорок три"
  #   propisju(221, 2) => "двести двадцать одна"
  def propisju(amount, gender = 1)
    if amount.is_a?(Integer) || amount.is_a?(Bignum)
      propisju_int(amount, gender)
    else # также сработает для Decimal, дробные десятичные числительные в долях поэтому женского рода
      propisju_float(amount)
    end
  end
  
  # Выводит целое или дробное число как сумму в гривнах прописью
  #
  #  griven(32) #=> "тридцать две гривны"
  def griven(amount)
    pts = []

    pts << propisju_int(amount.to_i, 2, "гривна", "гривны", "гривен") unless amount.to_i == 0
    if amount.kind_of?(Float)
      remainder = (amount.divmod(1)[1]*100).round
      if (remainder == 100)
        pts = [propisju_int(amount.to_i + 1, 2, 'гривна', 'гривны', 'гривен')]
      else
        pts << propisju_int(remainder.to_i, 2, 'копейка', 'копейки', 'копеек')
      end
    end
    
    pts.join(' ')
  end
  
  # Выводит сумму прописью в рублях по количеству копеек
  #
  #  kopeek(343) #=> "три рубля 43 копейки"
  def kopeek(amount)
    rublej(amount / 100.0)
  end

  # Выводит сумму данного существительного прописью и выбирает правильное число и падеж
  #
  #    RuPropisju.propisju_shtuk(21, 3, "колесо", "колеса", "колес") #=> "двадцать одно колесо"
  #    RuPropisju.propisju_shtuk(21, 1, "мужик", "мужика", "мужиков") #=> "двадцать один мужик"
  def propisju_shtuk(items, gender = 1, *forms)
    r = if items == items.to_i
      [propisju(items, gender), choose_plural(items, *forms)]
    else
      [propisju(items, gender), forms[1]]
    end
    
    r.join(" ")
  end
  
  private
  
  def compose_ordinal(into, remaining_amount, gender, one_item='', two_items='', five_items='')
    rest, rest1, chosen_ordinal, ones, tens, hundreds = [nil]*6
    #
    rest = remaining_amount % 1000
    remaining_amount = remaining_amount / 1000
    if rest == 0 
      # последние три знака нулевые 
      into = five_items + " " if into == ""
      return [into, remaining_amount]
    end
    #
    # начинаем подсчет с Rest
    chosen_ordinal = five_items
    
    # сотни
    hundreds = case rest / 100
      when 0 then ""
      when 1 then "сто "
      when 2 then "двести "
      when 3 then "триста "
      when 4 then "четыреста "
      when 5 then "пятьсот "
      when 6 then "шестьсот "
      when 7 then "семьсот "
      when 8 then "восемьсот "
      when 9 then "девятьсот "
    end

    # десятки
    rest = rest % 100
    rest1 = rest / 10
    ones = ""
    tens = case rest1
      when 0 then ""
      when 1 # особый случай
        case rest
          when 10 then "десять "
          when 11 then "одиннадцать "
          when 12 then "двенадцать "
          when 13 then "тринадцать "
          when 14 then "четырнадцать "
          when 15 then "пятнадцать "
          when 16 then "шестнадцать "
          when 17 then "семнадцать "
          when 18 then "восемнадцать "
          when 19 then "девятнадцать "
        end
      when 2 then "двадцать "
      when 3 then "тридцать "
      when 4 then "сорок "
      when 5 then "пятьдесят "
      when 6 then "шестьдесят "
      when 7 then "семьдесят "
      when 8 then "восемьдесят "
      when 9 then "девяносто "
    end
    #
    if rest1 < 1 or rest1 > 1 # единицы
      case rest % 10
        when 1
          ones = case gender
            when 1 then "один "
            when 2 then "одна "
            when 3 then "одно "
          end
          chosen_ordinal = one_item
        when 2
          if gender == 2
            ones = "две "
          else
            ones = "два " 
          end       
          chosen_ordinal = two_items
        when 3
          ones = "три "
          chosen_ordinal = two_items
        when 4
          ones = "четыре "
          chosen_ordinal = two_items
        when 5
          ones = "пять "
        when 6
          ones = "шесть "
        when 7
          ones = "семь "
        when 8
          ones = "восемь "
        when 9
          ones = "девять "
      end
    end
    
    plural = [hundreds, tens, ones, chosen_ordinal,  " ",  into].join.strip 
    return [plural, remaining_amount] 
  end
  
  DECIMALS = %w( целая десятая сотая тысячная десятитысячная стотысячная
      миллионная десятимиллионная стомиллионная миллиардная десятимиллиардная 
      стомиллиардная триллионная
  ).map{|e| [e, e.gsub(/ая$/, "ых"), e.gsub(/ая$/, "ых"), ] }.freeze
  
  # Выдает сумму прописью с учетом дробной доли. Дробная доля округляется до миллионной, или (если
  # дробная доля оканчивается на нули) до ближайшей доли ( 500 тысячных округляется до 5 десятых).
  # Дополнительный аргумент - род существительного (1 - мужской, 2- женский, 3-средний)
  def propisju_float(num)
    
    # Укорачиваем до триллионной доли
    formatted = ("%0.#{DECIMALS.length}f" % num).gsub(/0+$/, '')
    wholes, decimals = formatted.split(/\./)
    
    return propisju_int(wholes.to_i) if decimals.to_i.zero?
    
    whole_st = propisju_shtuk(wholes.to_i, 2, *DECIMALS[0])
    
    rem_st = propisju_shtuk(decimals.to_i, 2, *DECIMALS[decimals.length])
    [whole_st, rem_st].compact.join(" ")
  end
  
  # Выполняет преобразование числа из цифрого вида в символьное
  #
  #   amount - числительное
  #   gender   = 1 - мужской, = 2 - женский, = 3 - средний
  #   one_item - именительный падеж единственного числа (= 1)
  #   two_items - родительный падеж единственного числа (= 2-4)
  #   five_items - родительный падеж множественного числа ( = 5-10)
  # 
  # Примерно так:
  #   propisju(42, 1, "сволочь", "сволочи", "сволочей") # => "сорок две сволочи"
  def propisju_int(amount, gender = 1, one_item = '', two_items = '', five_items = '')
    
    return "ноль " + five_items if amount.zero?
    
    # единицы
    into, remaining_amount = compose_ordinal('', amount, gender, one_item, two_items, five_items)
    
    return into if remaining_amount == 0
    
    # тысячи
    into, remaining_amount = compose_ordinal(into, remaining_amount, 2, "тысяча", "тысячи", "тысяч") 
    
    return into if remaining_amount == 0
    
    # миллионы
    into, remaining_amount = compose_ordinal(into, remaining_amount, 1, "миллион", "миллиона", "миллионов")
    
    return into if remaining_amount == 0
    
    # миллиарды
    into, remaining_amount = compose_ordinal(into, remaining_amount, 1, "миллиард", "миллиарда", "миллиардов")
    return into
  end
  
  alias_method :rublja, :rublej
  alias_method :rubl, :rublej
  
  alias_method :kopeika, :kopeek
  alias_method :kopeiki, :kopeek
  
  alias_method :grivna, :griven
  alias_method :grivny, :griven
  
  
  public_instance_methods(true).map{|m| module_function(m) }
  
  module_function :propisju_int, :propisju_float, :compose_ordinal
end