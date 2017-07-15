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

	private

  def should_generate_new_friendly_id?
  	slug.nil? || title_changed?
	end

end
