module Admin
  class UsersController < BaseController
    # before_action :require_authentication
    # before_action :set_user!, only: %i[edit update destroy]
    # before_action :authenticate_user!
    # after_action :verify_authorized

    def index
      respond_to do |format|
        format.html do
          @users = User.order(created_at: :desc)
        end
    end

    def create

      redirect_to admin_users_path
    end

    def edit; end

    def update
      if @user.update user_params
        flash[:success] = t '.success'
        redirect_to admin_users_path
      else
        render :edit
      end
    end

    def destroy
      @user.destroy
      flash[:success] = t '.success'
      redirect_to admin_users_path
    end

    # private

    # def set_user!
    #   @user = User.find params[:id]
    # end

    # def user_params
    #   params.require(:user).permit(
    #     :email, :name, :password, :password_confirmation, :role
    #   ).merge(admin_edit: true)
    # end

    # def authorize_user!
    #   authorize(@user || User)
    # end
  end
end
end