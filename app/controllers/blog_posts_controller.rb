# frozen_string_literal: true
class BlogPostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_blog_post, only: %i[show edit update destroy]
  # bisa juga pakai except(kecuali): [:index, :new, :create]

  def index
    @blog_posts = user_signed_in? ? BlogPost.sorted : BlogPost.published
    @pagy, @blog_posts = pagy(@blog_posts)
  rescue Pagy::OverflowError
    # * Opsi pertama, mengembalikan page=over ke halaman 1, ramah SEO
    redirect_to root_path(page: 1)
    # * Opsi kedua, mengembalikan page=over ke halaman 1 TAPI tetep menggunakan url ngawur tadi. misal 100 menjadi 101 tapi datanya data halam ke 1, kelemahannya tidak ramah SEO
    # params[:page] = 1
    # retry
  end

  def show
    # @blog_post = BlogPost.find(params[:id])
    # rescue ActiveRecord::RecordNotFound
    #   redirect_to root_path
  end

  def new
    @blog_post = BlogPost.new
  end

  def create
    # @blog_post = BlogPost.new(params[blog_post]) #! Ini tidak aman, makanya dibuat private di bawah
    @blog_post = BlogPost.new(blog_post_params)
    if @blog_post.save
      redirect_to @blog_post
    else
      render :new, status: :unprocessable_entity
      # status di atas adalah fitur Rails, sehingg server tidak mengirim header 'ok'
    end
  end

  def edit
    # @blog_post = BlogPost.find(params[:id])
  end

  def update
    # @blog_post = BlogPost.find(params[:id])
    if @blog_post.update(blog_post_params)
      redirect_to @blog_post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    # @blog_post = BlogPost.find(params[:id])
    @blog_post.destroy
    redirect_to root_path
  end

  private

  def blog_post_params
    # * Ada alasan Khusus kenapa ada :content dan :cover_image
    # TODO: Pelajari lagi saja
    params.require(:blog_post).permit(:title, :content, :cover_image, :published_at)
  end

  def set_blog_post
    # * Awalnya Gini
    # if user_signed_in?
    #   @blog_post = BlogPost.find(params[:id])
    # else
    #   @blog_post = BlogPost.published.find(params[:id])
    # end
    # * Jadi gini
    @blog_post = user_signed_in? ? BlogPost.find(params[:id]) : BlogPost.published.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  # def authenticate_user!
  #   redirect_to new_user_session_path, alert: "You must sign in or sign up to continue." unless user_signed_in!
  # end
  # ! Tidak perlu pakai coding ini, karena "authenticate_user" sudah dibuatkan Rails
end
