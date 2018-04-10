class Admin::UsersController < AdminController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  def index
    @users = User.all.order(updated_at: :desc)
    authorize [:admin, @users]
  end

  # GET /users/1
  def show
  end

  # GET /users/new
  def new
    @user = User.new
    authorize [:admin, @user]
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  def create
    @user = User.new(user_params)
    authorize [:admin, @user]

    if @user.save
      flash[:success] = "建立成功。"
      redirect_to admin_users_path
    else
      render :new
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      flash[:success] = "更新成功。"
      redirect_to [:admin, @user]
    else
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    if User.all.size <= 1
      flash[:danger] = "至少要留一個帳號。"
      redirect_to admin_users_url
    else
      @user.destroy
      flash[:success] = "刪除成功。"
      if current_user == @user
        authorize [:admin, :session], :destroy?
        session.delete(:user_id)
        @current_user = nil
        redirect_to admin_login_path
      else
        redirect_to admin_users_url
      end
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    	authorize [:admin, @user]
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation, :password_digest)
    end
end