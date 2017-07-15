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
end
