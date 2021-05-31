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

  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follower
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :user


  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/, message: '全角文字を使用してください' } do
    validates :first_name
    validates :last_name
  end

  with_options presence: true, format: { with: /\A[ァ-ヶ]+\z/, message: 'カタカナでお願いします' } do
    validates :first_name_kana
    validates :last_name_kana
  end

  with_options format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i } do
    validates :password
  end

  with_options numericality: { other_than: 1 } do
    validates :prefecture_id
  end

  with_options presence: true do
    validates :birthday
    validates :nickname
    validates :city_town
  end

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
      self.relationships.find_or_create_by!(follower_id: other_user.ids)
    end
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end
end


