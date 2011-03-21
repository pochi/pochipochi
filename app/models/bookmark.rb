class Bookmark < ActiveRecord::Base
  default_scope :order => 'created_at DESC'
  # default paginate num(can override)
  paginates_per 5

  def self.search(search)
    if search
      search = search.first if search.is_a?(Array)
      where("title LIKE ?", "%#{search}%")
    else
      scoped
    end
  end
end
