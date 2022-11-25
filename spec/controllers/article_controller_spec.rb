# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  let(:user) { create(:user) }
  before { sign_in user }

  describe 'GET #index' do
    subject { get :index }
    include_examples 'not_authorized'  

    let(:articles) { create_list(:article, 4) }
        
    it 'return 200' do
      expect(subject.status).to eq(200)
    end

    it 'return data' do
      subject
      expect(assigns(:articles)).to match_array(articles)
    end    
    
    
  end

  describe 'GET #show' do
    subject { get :show, params: params }
    include_examples 'not_authorized'

    let(:article) { create(:article) }
    let(:params) { {id: article.id} }

    it 'return 200' do
      expect(subject.status).to eq(200)
    end

    it 'return data' do
      subject
      expect(assigns(:article)).to eq(article)
    end

    it 'not found' do
      params.update({id: 'invalid'})
      subject
      expect(subject).to redirect_to(not_found_index_path)
    end
  end

  describe 'GET #new' do
    subject { get :new }
    include_examples 'not_authorized'
  
    it 'return 200' do
      expect(subject.status).to eq(200)
    end
  end

  describe 'POST #create' do
    subject { post :create, params: params }
    include_examples 'not_authorized'

    let(:params) do
      {
        article: {
          title: 'Cleaning wipes',
          body: 'Can be used to clean',
          status: 'published'
        }
      }
    end
    let(:article) { assigns(:article) }

    it 'complete create' do
      subject
      expect(subject.status).to eq(302)
      expect(subject).to redirect_to(article)
    end

    it 'wrong information' do
      params.update({ 
        article: {
          title: 'only title'
        }
      })
      subject
      expect(subject).to render_template(:new)
      expect(subject).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'GET #edit' do
    subject { get :edit, params: params }
    include_examples 'not_authorized'

    let(:article) { create(:article) }
    let(:params) { {id: article.id} }

    it 'return 200' do
      expect(subject.status).to eq(200)
    end

    it 'return data' do
      subject
      expect(assigns(:article)).to eq(article)
    end

    it 'not found' do
      params.update({id: 'invalid'})
      subject
      expect(subject).to redirect_to(not_found_index_path)
    end
  end

  describe 'PUT #update' do
    subject { put :update, params: params}
    include_examples 'not_authorized'

    let(:article) { create(:article) }
    let(:params) { 
      { 
        id: article.id,
        article: { 
          title: article.title, 
          body: article.body, 
          status: article.status
        }
      } 
    }
    
    it 'complete update' do
      subject
      expect(subject.status).to eq(302)
      expect(subject).to redirect_to(article)
    end

    it 'wrong information' do
      params.update({
        article: {
          title: article.title,
          body: '',
          status: ''
        }
      })
      subject
      expect(subject).to render_template(:edit)
      expect(subject).to have_http_status(:unprocessable_entity)
    end

    it 'not found' do
      params.update({
        id: 'invalid'
      })
      subject
      expect(subject).to redirect_to(not_found_index_path)
    end
  end

  describe 'DELETE #destroy' do
    subject { delete :destroy, params: params }
    include_examples 'not_authorized'

    let(:article) { create(:article) }
    let(:params) { {id: article.id} }

    it 'delete success' do
      subject
      expect(subject).to have_http_status(:see_other)
      expect(subject).to redirect_to(root_path)
    end

    it 'not found' do
      params.update({id: 'invalid'})
      subject
      expect(subject).to redirect_to(not_found_index_path)
    end
  end
end
