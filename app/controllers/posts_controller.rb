class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :get_tiers

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    #t = @post.tier_id.split(',')
  end

  # GET /posts/new
  def new
    @post = Post.new
    tiers = Tier.all
    @tier_dist = {}
    tiers.each do |tier|
      @tier_dist[tier.id.to_s] = false
    end
  end

  # GET /posts/1/edit
  def edit
    @tier_dist = {}
    @post.tier_id.split(',').each do |t|
      i = t.split(':')
      if i[1] == 'true'
        @tier_dist[i[0]] = true
      else
        @tier_dist[i[0]] = false
      end
    end
  end

  # POST /posts
  # POST /posts.json
  def create
    params["post"]["tier_id"] = ""
    params.each do |k,v|
      if k.include? 'tier'
        post_params["tier_id"] << v + ','
      end
    end
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    params["post"]["tier_id"] = ""
    params.each do |k,v|
      if k.include? 'tier'
        post_params["tier_id"] << v + ','
      end
    end

    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content, :tier_id, :public_post)
    end

    def get_tiers
      @tiers = Tier.all
    end
end