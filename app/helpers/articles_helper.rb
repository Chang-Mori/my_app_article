module ArticlesHelper
  def article_lists(articles)
    html = ''
    articles.each do |article|
      html += render(partial: "article", locals: { article: article })
    end
    return raw(html)
  end
end
