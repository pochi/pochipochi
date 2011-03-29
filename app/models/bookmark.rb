class Bookmark < ActiveRecord::Base
  # default_scope :order => 'created_at DESC'
  # default paginate num(can override)
  paginates_per 10

  def self.search(search)
    if search
      where("title LIKE ?", "%#{search}%")
    else
      scoped
    end
  end
end
