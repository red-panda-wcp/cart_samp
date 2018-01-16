class ItemsController < ApplicationController

  def index
  	@items = Item.all
  end

  def show
    #ログインユーザー情報、商品情報、受け渡しカート情報をそれぞれ取得する
    @item = Item.find(params[:id])
    #詳細画面の商品情報を取得

    if current_user #ユーザーがいれば表示
      @user = User.find(current_user.id)
        if Cart.find_by(user_id:@user.id,item_id:@item.id).present?
        @cart = Cart.find_by(user_id:@user.id,item_id:@item.id)
        # すでにログインユーザーかつ同じ商品のカートがある場合
      else
        @cart = Cart.new
        #　ログインユーザーかつ同じ商品のカートがない場合
      end
    end
  end
end