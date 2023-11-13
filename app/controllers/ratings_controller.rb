class RatingsController < ApplicationController

  before_action :set_topic
  before_action :set_post
  before_action :set_rating, only: %i[ show edit update destroy ]

  # GET /ratings or /ratings.json
  def index
    @ratings = @post.ratings
  end

  # GET /ratings/1 or /ratings/1.json
  def show
  end

  # GET /ratings/new
  def new
    @rating = @post.ratings.build
  end

  # GET /ratings/1/edit
  def edit
  end

  # POST /ratings or /ratings.json
  def create
    @rating = @post.ratings.build(rating_params)

    respond_to do |format|
      if @rating.save
        format.html { redirect_to topic_post_url(@topic, @post), notice: "Rating was successfully created." }
        format.json { render :show, status: :created, location: @rating }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ratings/1 or /ratings/1.json
  def update
    respond_to do |format|
      if @rating.update(rating_params)
        format.html { redirect_to topic_post_rating_url(@topic, @post, @rating), notice: "Rating was successfully updated." }
        format.json { render :show, status: :ok, location: @rating }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ratings/1 or /ratings/1.json
  def destroy
    @rating.destroy

    respond_to do |format|
      format.html { redirect_to topic_post_ratings_url(@topic, @post), notice: "Rating was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_topic
      @topic = Topic.find(params[:topic_id])
    end

    def set_post
      @post = @topic.posts.find(params[:post_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_rating
      @rating = @post.ratings.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def rating_params
      params.require(:rating).permit(:value, :post_id)
    end
end
