FactoryBot.define do
  factory :comment do
    commenter { 'commenter'}
    body { 'this body must be 10'}
    status { 'published'}
    article { create(:article) }
  end
end
