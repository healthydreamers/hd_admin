# == Schema Information
#
# Table name: articles
#
#  id          :integer          not null, primary key
#  title       :string           default(""), not null
#  description :text             default(""), not null
#  url         :string           default("")
#  source_host :string           default("")
#  slug        :string
#  topic_id    :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Article < ApplicationRecord
  acts_as_votable
  acts_as_taggable

  after_commit :set_og_values, on: :create
  after_commit :slack_notification, on: :create

  belongs_to :topic
  belongs_to :user
  has_many :comments, as: :commentable

  validates :url, presence: true
  
  scope    :published,    -> { where(articles: { is_published: true }) }
  scope    :unpublished,  -> { where(articles: { is_published: false }) }

  extend FriendlyId
  friendly_id :title, use: :slugged


  def set_og_values
    Posts::ArticleCrawlerWorker.perform_in(1.minutes, id)
  end

  def slack_notification
    Notifications::ArticleNotificationWorker.perform_in(2.minutes, id)
  end

  def count_user_articles
    "User.articles.count"
  end

  def post_to_facebook
    page_graph = Koala::Facebook::API.new(ENV["access_token"])
    page_graph.put_wall_post(description, {
      name: title,
      link: "https://www.healthydreamers.com/articles/" + slug + "?utm_source=healthydreamers&utm_medium=facebook",
      caption: title,
      #description: "Healthy Dreamers is a curation of articles & videos to help you follow a Healthy, Wealthy & Wise life.",
      picture: image_url
    }, ENV["page_id"])
  end

  private
  
  def should_generate_new_friendly_id?
    slug.nil? || title_changed?
  end

end
