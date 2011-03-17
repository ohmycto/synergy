Taxon.class_eval do
  before_update :set_permalink
end
