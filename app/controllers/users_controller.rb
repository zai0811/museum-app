class UsersController < ApplicationController
  prepend_before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    @q = User.ransack(params[:q])
    @q.sorts = 'first_name asc' if @q.sorts.empty?
    @pagy, @users = pagy(@q.result)
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: t(".success") }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: t(".success") }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :show, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy!

    respond_to do |format|
      format.html { redirect_to users_url, notice: t(".success") }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user)
          .permit(:first_name,
                  :last_name,
                  :email,
                  :ci,
                  :password_digest,
                  :phone_number,
                  :profile_picture
          )
  end

  def authorize_user!
    authorized = case action_name
                 when "show", "update", "edit"
                 then current_user
                 else
                   current_user.admin?
                 end
    not_authorized unless authorized
  end
end
