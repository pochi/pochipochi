class Bookmark < ActiveRecord::Base
  default_scope :order => 'created_at DESC'
  # default paginate num(can override)
  paginates_per 5
end
