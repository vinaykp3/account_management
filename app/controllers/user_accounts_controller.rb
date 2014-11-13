class UserAccountsController < ApplicationController
  before_action :set_user_account, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @user_accounts = UserAccount.all
  end

  def sign_out_user
    $redis.del "user_#{current_user.id}"
    sign_out :user
    redirect_to root_path
  end  

  private
    def set_user_account
      @user_account = UserAccount.find(params[:id])
    end

    def user_account_params
      params.require(:user_account).permit(:name, :transaction_date, :transaction_place, :transaction_amount)
    end
end
