class TagsController < ApplicationController

  def search
    # return nil if params[:keyword] == ""
    # tag = Tag.where(['tag_name LIKE ?', "%#{params[:keyword]}%"] )
    # render json:{ keyword: tag}
  end

end
