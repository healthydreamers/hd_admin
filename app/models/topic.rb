# == Schema Information
#
# Table name: topics
#
#  id         :integer          not null, primary key
#  name       :string           default(""), not null
#  slogan     :string           default(""), not null
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Topic < ApplicationRecord
	has_many :articles
	
	scope 	 :published_articles, 		-> { includes(:articles).where(articles: { is_published: true }) }
	scope 	 :healthy_articles, 			-> { includes(:articles).where(topics: { name: "Healthy" }, articles: { is_published: true }) }
	scope 	 :wealthy_articles, 			-> { includes(:articles).where(topics: { name: "Wealthy" }, articles: { is_published: true }) }
	scope 	 :wise_articles, 					-> { includes(:articles).where(topics: { name: "Wise" }, articles: { is_published: true }) }

	extend FriendlyId
	friendly_id :name, use: :slugged
	
	private

	def should_generate_new_friendly_id?
  	slug.nil? || name_changed?
	end
end
