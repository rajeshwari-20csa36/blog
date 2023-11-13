class PostsController < ApplicationController

  before_action :set_topic
  before_action :set_post, only: %i[ show edit update destroy ]
  # load_and_authorize_resource
  # skip_authorize_resource :only => :read_unread

  # GET /posts or /posts.json
  def index
    if params[:search] && params[:search][:date].present?
      start_date, end_date = params[:search][:date].split(' - ')
      @pagy, @posts = pagy(Post.having_date_between(start_date, end_date))
      puts @posts.count
    elsif params[:tag]
      @pagy, @posts = pagy(Post.tagged_with(params[:tag]))
    elsif params[:topic_id].present?
      @pagy, @posts = pagy(@topic.posts.includes(:users))
    else
      @pagy, @posts = pagy(Post.includes(:topic, :users).all)
    end
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = @topic.posts.build
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    sleep 0.5
    @post = @topic.posts.build(post_params)
    @post.user_id = current_user.id
    respond_to do |format|
      if @post.save
        # CrudNotificationMailer.create_notification(@post).deliver_now
        format.html { redirect_to topic_post_url(@topic,@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
        format.js
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
        format.js {flash.now[:error] = @post.errors.full_messages}
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        # CrudNotificationMailer.update_notification(@post).deliver_now
        format.html { redirect_to topic_post_url(@topic,@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    # CrudNotificationMailer.delete_notification(@post).deliver_now
    @post.destroy
    respond_to do |format|
      format.html { redirect_to topic_posts_url(@topic), notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  def read_unread
    @post.users << current_user
    head :ok
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_topic
    if params[:topic_id]
      @topic = Topic.find(params[:topic_id])
    end
  end
  def set_post
    @post = @topic.posts.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:headline, :content, :topic_id, :post_image, tag_ids: [])
  end
end