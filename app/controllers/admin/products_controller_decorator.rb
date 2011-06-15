# coding: utf-8
Admin::ProductsController.class_eval do
  require 'nokogiri'
  require 'open-uri'

  update.before :nullify_description_if_blank
  create.before :nullify_description_if_blank

  def import_from_yandex_market
    if params[:model_id].to_i > 0
      market_url = "http://market.yandex.ru/model.xml?modelid=#{params[:model_id]}"
    else
      market_url = params[:model_id]
    end
    taxonomy = Taxonomy.find_or_create_by_name("Категории")
    begin
      doc = Nokogiri::HTML(open(market_url))

      nbsp = [194.chr, 160.chr].join

      properties = {}
      doc.css('#main-spec-cont tr').each do |tr|
        key = tr.children[0].content.strip
        next if key == nbsp
        properties[key] = tr.children[1].content.strip
      end

      taxon_name = doc.css(".b-breadcrumbs a").last.content
      price = doc.css(".b-model-prices__avg span").first.content.gsub(nbsp, '')
      image_urls = doc.css("#model-pictures a").map{|link| link['href'] }
      name = doc.css(".b-page-title").first.content

      p = Product.new(:name => name, :price => price)
      p.available_on = Time.now if params[:available]
      if p.valid?
        taxon = Taxon.find_by_name(taxon_name)
        taxon ||= Taxon.create(:name => taxon_name, :taxonomy_id => taxonomy.id, :parent_id => taxonomy.root.id)
        p.taxons << taxon
        properties.each do |prop_name, value|
          full_prop_name = [taxon_name, prop_name].join(': ')
          property = Property.find_by_name(full_prop_name)
          property ||= Property.create(:name => full_prop_name, :presentation => prop_name)
          p.product_properties << ProductProperty.new(:property_id => property.id, :value => value)
        end

        image_urls.each do |url|
          p.images << Image.new(:attachment => download_remote_image(url))
        end
        if p.save
          flash[:notice] = "Данные о товаре \"#{p.name}\" успешно скачены с Яндекс.Маркет"
        end
      end
    rescue Exception => error
      flash[:notice] = "Данные о товаре не удалось взять с Яндекс.Маркет, проверьте ID товара и наличие полной информации о нём по ссылке #{market_url}."
      flash[:error] = error.backtrace.find{|line| line =~ /#{__FILE__}/}.to_s + "(#{$!})"
    end
    redirect_to admin_products_path
  end

  def nullify_description_if_blank
    description = params[object_name][:description]
    if description && ActionController::Base.helpers.strip_tags(description).gsub('&nbsp;', '').strip.empty?
      params[object_name][:description] = nil
    end
  end

  private

  def download_remote_image(image_url)
    io = open(URI.parse(image_url))
    def io.original_filename; [base_uri.path.split('/').last, '.jpg'].join; end
    io.original_filename.blank? ? nil : io
  rescue # catch url errors with validations instead of exceptions (Errno::ENOENT, OpenURI::HTTPError, etc...)
  end
end
