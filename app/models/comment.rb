# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  body       :text
#  commenter  :string
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  article_id :integer          not null
#
# Indexes
#
#  index_comments_on_article_id  (article_id)
#
# Foreign Keys
#
#  article_id  (article_id => articles.id)
#
class Comment < ApplicationRecord
  include Visible


  belongs_to :article

  validates :commenter, presence: true
  validates :body, presence: true, length: { minimum: 10 }
end
