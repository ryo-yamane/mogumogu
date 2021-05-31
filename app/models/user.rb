class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[facebook google_oauth2]

  has_many :tweets, dependent: :destroy
  has_many :comments
  has_many :sns_credentials

  has_many :likes, dependent: :destroy
  has_many :like_tweets, through: :likes, source: :tweet

  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user

  # SNS認証
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
  # SNS認証

  # いいね機能
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
  # いいね機能

  # フォロー機能
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationships.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

end

