class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)    # 実装は終わっていないことに注意!
    if @user.save
      sign_in @user
      # 保存の成功をここで扱う。
      flash[:success] = "Welcome to sample app!!"
      redirect_to @user
    else
      # 保存の失敗をここで扱う。
      # またnewアクションを実行するだけ
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
