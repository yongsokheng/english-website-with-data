class Article < ActiveRecord::Base
  acts_as_paranoid
  mount_uploader :image, ImageUploader

  belongs_to :category
  belongs_to :user

  validates :title, presence: true
  validates :content, presence: true
  validates :image, presence: true
  validate :schedule_at_must_greater_than_current_datetime

  scope :on_schedule, ->{where("schedule_at <= ? and post_status = ?",
    Time.zone.now, Settings.post_status.pending)}
  scope :draft, ->{where post_status: Settings.post_status.draft}
  scope :pending, ->{where post_status: Settings.post_status.pending}
  scope :published, ->{where post_status: Settings.post_status.published}

  scope :find_published_articles, ->limit, offset, category_id{
    joins(:category).where("post_status = ? AND category_id = ?",
        Settings.post_status.published, category_id)
      .order("published_at DESC")
      .limit(limit)
      .offset(offset)
  }

  scope :find_similar_articles, ->limit, except, category_id{
    joins(:category).where("post_status = ? AND category_id = ? AND articles.id <> ?",
      Settings.post_status.published, category_id, except)
    .order("published_at DESC")
    .limit(limit)}

  scope :select_popular, ->limit, except{where("post_status = ? AND articles.id <> ?",
      Settings.post_status.published, except)
    .order("view DESC")
    .limit(limit)}

  after_restore :update_post_status, if: :pending?

  def schedule_at_must_greater_than_current_datetime
    return if schedule_at.blank?
    errors.add :schedule_at, I18n.t("validate.datetime_error") if schedule_at < Time.zone.now
  end

  def pending?
    post_status == Settings.post_status.pending
  end

  def update_post_status
    if schedule_at <= Time.zone.now
      update_attributes post_status: Settings.post_status.draft,
        schedule_at: nil
    end
  end

  def update_view_number
    view = self.view || 0
    update_attributes view: view + 1
  end
end
