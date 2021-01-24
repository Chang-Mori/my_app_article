class RelationshipsController < ApplicationController

  def create
    @other_user = User.find(params[:follower])
    current_user.follow(@other_user)
  end

  def destroy
    @user = current_user.relationships.find(params[:id]).follower
    current_user.unfollow(params[:id])
  end

  def follower #follower一覧
    user = User.find(params[:user_id])
    @users = user.following_user
    # .follower_userメソッド ：Userモデルで定義済
  end

  def followed #followed一覧
    user = User.find(params[:user_id])
    @users = user.follower_user
    # .follower_userメソッド ：Userモデルで定義済
  end
end
