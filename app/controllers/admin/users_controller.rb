# frozen_string_literal: true

module Admin
  class UsersController < ApplicationController
    before_action :authenticate_admin!
    before_action :set_user, only: %i[edit update destroy]

    def index
      respond_to do |format|
        format.html do
          @users = User.order(created_at: :desc)
        end
      end
    end

    def edit; end

    def create
      def create
        @user = User.new(user_params)

        respond_to do |format|
          if @user.save
            format.html { redirect_to admin_users_path(@user), notice: 'User was successfully created.' }
          else
            format.html { render :index, status: :unprocessable_entity }
          end
        end
      end
    end

    def update
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to admin_users_path, notice: 'User was successfully updated.' }
        else
          format.html { render :edit, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @user.destroy
      flash[:success] = 'success'
      redirect_to admin_users_path
    end

    private

    def authenticate_admin!
      authenticate_user!
      redirect_to movies_path, status: :forbidden unless current_user.admin_role?
    end

    def set_user
      @user = User.find params[:id]
    end

    def user_params
      params.require(:user).permit(:email, :role)
    end
  end
end
