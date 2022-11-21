FactoryBot.define do
  factory :comment do
    commenter { 'commenter'}
    body { 'this body must be 10'}
    status { 'published'}
    article_id { create(:article).id }
  end
end
