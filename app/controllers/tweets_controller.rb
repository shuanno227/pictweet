class TweetsController < ApplicationController
  before_action :set_tweet, only: [:edit, :show]
  # indexアクションにアクセスした場合、indexアクションへのリダイレクトを繰り返してしまい、
  # 無限ループが起こります。対策として、except: :indexを付け加えます。
  # また、ログインしていなくても、詳細ページには遷移できる仕様にするためにexcept: [:index, :show]としています。
  before_action :move_to_index, except: [:index, :show, :search]

  def index
    @tweets = Tweet.includes(:user).order("created_at DESC")
  end

  def new
    @tweet = Tweet.new
  end

  def create
    Tweet.create(tweet_params)
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
  end

  def edit
  end

  def update
    tweet = Tweet.find(params[:id])
    tweet.update(tweet_params)
  end

  def show
    @comment = Comment.new
    @comments = @tweet.comments.includes(:user)
  end
  
  def search
    @tweets = Tweet.search(params[:keyword])
  end

  private
  def tweet_params
    # current_userメソッド:現在ログインしているユーザーの情報を取得できる
    # mergeメソッドでログイン中のユーザーのid(current_user.id)の値をtweetsテーブルの投稿者を示すカラムuser_idに保存する
    params.require(:tweet).permit(:image, :text).merge(user_id: current_user.id)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  # unless ~と続いているのはunless文です。
  # このように書くと、先にuser_signed_in?で判定をして、その返り値がfalseだった場合に手前の式を実行するということになります。
  # 即ち、ユーザーがログインしていない場合にはindexアクションが実行されます。
  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end

