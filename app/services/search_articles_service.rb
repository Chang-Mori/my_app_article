class SearchArticlesService
  def self.search(search)
    if search != ""
      Article.where('text LIKE(?)', "%#{search}%")
      # Article.where('title LIKE(?)', "%#{search}%")
    else
      Article.all
    end
  end
end