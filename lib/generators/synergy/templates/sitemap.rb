# https://github.com/kjvarga/sitemap_generator

HTTP_PREFIX = 'http://'
site_url = Spree::Config['site_url']
unless site_url.start_with?(HTTP_PREFIX)
  site_url = HTTP_PREFIX + site_url
end
SitemapGenerator::Sitemap.default_host = site_url
SitemapGenerator::Interpreter.send :include, Spree::Core::Engine.routes.url_helpers

SitemapGenerator::Sitemap.create do
  Spree::Product.active.find_each do |product|
    add product_path(product), :lastmod => product.updated_at
  end

  Spree::Page.visible.find_each do |page|
    add page.slug, :lastmod => page.updated_at
  end
end