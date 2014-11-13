class UserAccountsController < ApplicationController
  before_action :set_user_account, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @user_accounts = UserAccount.all
    if request.referrer.nil?
      redirect_to $redis.get("user_#{current_user.id}")
    else  
      respond_with(@user_accounts)
    end  
  end

  def show
    respond_with(@user_account)
  end

  def new
    @user_account = UserAccount.new
    respond_with(@user_account)
  end

  def edit
  end

  def create
    @user_account = UserAccount.new(user_account_params)
    @user_account.save
    respond_with(@user_account)
  end

  def update
    @user_account.update(user_account_params)
    respond_with(@user_account)
  end

  def destroy
    @user_account.destroy
    respond_with(@user_account)
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
