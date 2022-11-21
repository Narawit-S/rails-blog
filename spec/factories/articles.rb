# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  body       :text
#  status     :string
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :article do
    title { 'title' }
    body { 'body is must be 10' }
    status { 'published' }
  end
end
