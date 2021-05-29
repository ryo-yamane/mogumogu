class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  
  has_many :tweets , dependent: :destroy
  has_many :comments
  has_many :sns_credentials

  has_many :likes, dependent: :destroy
  has_many :like_tweets, through: :likes, source: :tweet

  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    # sns認証したことがあればアソシエーションで取得
   # 無ければemailでユーザー検索して取得orビルド(保存はしない)
   user = User.where(email: auth.info.email).first_or_initialize(
    nickname: auth.info.name,
      email: auth.info.email
  ) 
  # userが登録済みであるか判断
  if user.persisted?
    sns.user = user
    sns.save
  end
  { user: user, sns: sns }
  end

  def own?(object)
    id == object.user_id
  end

  def like(tweet)
    likes.find_or_create_by(tweet: tweet)
  end

  def like?(tweet)
    like_tweets.include?(tweet)
  end

  def unlike(tweet)
    like_tweets.delete(tweet)
  end
end
