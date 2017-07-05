class Micropost < ApplicationRecord
  belongs_to :user
  has_many :mentioned_replies, class_name: "Reply",
              foreign_key: "destination_id"
  has_many :mention_replies, class_name: "Reply",
              foreign_key: "micropost_id"
  has_many :mentioned, through: :mentioned_replies, source: :destination
  has_many :mention, through: :mention_replies, source: :micropost
  default_scope -> {order(created_at: :desc)}
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 140}
  validate :picture_size

  before_save :reply_true


  def reply_true
    self.reply = true if is_reply?
  end

  def is_reply?
    if screen_name = content.match(/(?<!\w)@\w+/i)
      pick_user_from_micropost_content(screen_name[0]) ? true : false
    else
      false
    end
  end

  def make_reply(address = nil)
    screen_name = content.match(/(?<!\w)@\w+/i)[0]
    user = pick_user_from_micropost_content(screen_name)
    Reply.create do |n|
      n.micropost_id = self.id
      n.destination_id = address if address
    end
  end

  def pick_user_from_micropost_content(screen_name)
      screen_name[0] = ""     # @の取り除き
      User.find_by(screen_name: screen_name)
  end


  private

    # アップロードされた画像のサイズをバリデーションする
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
