class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :logged_in, except: %i[login checklog]
  # GET /users or /users.json
  
  def logged_in
    if(session[:user_id])
      return true
    else
      redirect_to main_path, notice: "Please Login"
    end
  end

  def login
    session[:user_id] = nil
  end

  def checklog
    @email=params[:email]
    @pass=params[:password]
    @user = User.find_by({email:@email})
    if @user.present? && @user.authenticate(@pass)
      redirect_to feed_url , notice: "login successfully"
      session[:user_id]=User.find_by({email:@email}).id
    else
      render:wrong
    end
  end

  def feed
    @user = User.find_by(id:session[:user_id])
    @posts = @user.get_feed_post 
    
  end

  def profile
    @user = User.find_by(name:params[:name])
    @current_user = User.find_by(id:session[:user_id])
    @posts = @user.posts.order('created_at DESC')
     
  end

  def follow
    @user = User.find(params[:id])
    @current_user = User.find_by(id:session[:user_id])
    @current_user.followees << @user
    #redirect_back(fallback_location: feed_path)
    redirect_to feed_path
  end

  def unfollow
    @user = User.find(params[:id])
    @current_user = User.find_by(id:session[:user_id])
    @current_user.followed_users.find_by(followee_id: @user.id).destroy
    #redirect_back(fallback_location: feed_path)
    redirect_to feed_path
  end

  def index
    @users = User.all
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
        format.html { redirect_to @user, notice: "User was successfully created." }
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
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
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
      params.require(:user).permit(:email, :name, :password)
    end
end
