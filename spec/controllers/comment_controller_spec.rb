# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe 'POST #create' do
    subject { post :create, params: params}

    let(:article) { create(:article) }
    let(:params) {
      {
        article_id: article.id,
        comment: {
          commenter: 'Kaowlad',
          body: 'this is a comment form kaowlad',
          status: 'published'
        }
      }
    }

    it 'comment complete' do
      subject
      expect(subject).to have_http_status(:found)
      expect(subject).to redirect_to(article)
    end

    it 'not found article' do
      params.update({
        article_id: 'invalid'
      })
      subject
      expect(subject).to redirect_to(not_found_index_path)
    end
  end

  describe 'DELETE #destroy' do
    subject { delete :destroy, params: params}

    let(:comment) { create(:comment) }
    let(:params) {
      {
        id: comment.id,
        article_id: comment.article_id
      }
    }

    it 'delete success' do
      subject
      expect(subject).to have_http_status(:see_other)
      expect(subject).to redirect_to(article_path(comment.article_id))
    end

    it 'not found article' do
      params.update({
        article_id: 'invalid'
      })
      subject
      expect(subject).to redirect_to(not_found_index_path)
    end

    it 'not found comment' do
      params.update({
        id: 'invalid'
      })
      subject
      expect(subject).to redirect_to(not_found_index_path)
    end
  end
end 
