class CartsController < ApplicationController
  def create #carts_path
    @item = Item.find(params[:cart][:item_id])
    #フォームから送信されてきた商品情報から商品を特定

    @cart = Cart.new(params_cart)
    @cart.item_id = @item.id
    @cart.user_id = current_user.id
    #カートの新規作成、情報のセット

    if @item.stock >= params[:count].to_i #セットできる数字の上限を指定
      @cart.count = params[:count]
      @cart.save
      redirect_to edit_carts_path #カート画面へ
    else
      redirect_to item_path(@item) #アイテム詳細画面へ。？？ここで入れた数字は保持していたほうがいい？
    end
  end

  def add
    @item = Item.find(params[:cart][:item_id])
    #フォームから送信されてきた商品情報から商品を特定
    @cart = Cart.find_by(item_id:@item.id,user_id:current_user.id)
    #カートの既存カートの特定

    if @item.stock >= params[:count].to_i #セットできる数字の上限を指定
      @cart.count = params[:count]
      @cart.save
      redirect_to edit_carts_path #カート画面へ
    else
      redirect_to item_path(@item) #アイテム詳細画面へ。？？ここで入れた数字は保持していたほうがいい？
    end
  end

  def edit #edit_carts_path カート画面
    @user = User.find(current_user.id)
    @carts = Cart.where(user_id:@user.id)
  end

  def update
    #カートアイテムの特定
    @cart = Cart.find(params[:id])
    #カート無アイテム全ての取得
    @carts = Cart.where(user_id:@cart.user_id)
    @item = @cart.item

    if params[:count].to_i == 0
      @cart.destroy
      #変更数が０の場合は削除する
      if @carts.present?
        redirect_to edit_carts_path #カート画面へ
      else
        redirect_to items_path #indexへ
      end
    elsif @item.stock >= params[:count].to_i
      @cart.count = params[:count]
      @cart.update(params_cart)
      redirect_to edit_carts_path #カート画面へ
    else
      redirect_to edit_carts_path #カート画面へ
    end

  end

  def destroy #cart_path(@item),method: :delete
    @cart = Cart.find(params[:id])
    @cart.destroy
    redirect_to edit_carts_path #カート画面へ
  end

  private
  def params_cart
    params.permit(:cart).permit(:user_id,:item_id,:count)
  end
end
