class User < ApplicationRecord
  has_many :microposts, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
                  foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                  foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :notifications, class_name: "Notification", foreign_key: "notifier_id"
  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users
  has_many :comments, dependent: :destroy
  has_many :book_users
  has_many :books, through: :book_users

  attr_accessor :remember_token, :activation_token, :reset_token
  before_save :downcase_email
  before_create :create_activation_digest
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255}, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true
  VALID_SCREENNAME_REGEX = /(?<!\w)\w+/i
  validates :screen_name, presence: true, length: {maximum: 15}, uniqueness: {case_sensitive: false}, format: {with: VALID_SCREENNAME_REGEX}


  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # 永続セッションのためにユーザをデータベースに記憶する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # ユーザのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end

  # アカウントを有効にする
  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end

  # 有効化用のメールを送信する
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  # パスワード再設定の属性を設定する
  def create_reset_digest
    self.reset_token = User.new_token
    update_columns(reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now)
  end

  # パスワード再設定のメールを送信する
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # パスワード再設定の期限が切れている場合はtrueを返す
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  # ユーザのステータスフィードを返す
  def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE follower_id = :user_id"
    Micropost.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
  end

  def follow(other_user)
    follow = active_relationships.create(followed_id: other_user.id)
    # ßself.notifications.create(follow)
    Notification.create do |n|
      n.notifier_id = other_user.id
      n.notificationable = follow
      n.body = "create"
    end
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  # ownerユーザとしてグループに参加
  def join_group_by_admin(group_id)
    self.join_group(group_id, 1)
  end

  # 一般ユーザとしてグループ参加
  def join_group_by_member(group_id)
    self.join_group(group_id, 2)
  end

  # グループ参加
  def join_group(group_id, role)
    group_users.create{ |n|
    n.user_id = self.id
    n.group_id = group_id
    n.role = role }
  end

  def joining?(group)
    groups.include?(group)
  end

  # グループ脱退
  def defect(group_id)
    group_users.find_by(group_id: group_id).destroy
  end

  def owner?(group_id)
    if group_user = group_users.find_by(group_id: group_id)
      group_user.role == 1
    end
  end


  # 読書管理機能のメソッド

  def register_book_as_owner(book)
    self.register_book(book, 1)
  end

  def register_book_as_normal_user(book)
    self.register_book(book, 2)
  end

  def register_book(book, role)
    book_user = book_users.create do |n|
      n.book_id = book.id
      n.user_id = self.id
      n.role = role
    end
  end

  def delete_book_registration(book)
    book_users.find_by(book_id: book.id).destroy
  end

  def book_is_registered?(book)
    books.include?(book)
  end

  def book_owner?(book)
    return false unless bookuser = book_users.find_by(book_id: book.id)
    bookuser.role == 1 ? true : false
  end



  private
  # メールアドレスをすべて小文字にする
  def downcase_email
    self.email.downcase!
  end

  # 有効化トークンとダイジェストを作成及び代入する
  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
