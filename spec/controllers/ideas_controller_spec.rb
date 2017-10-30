require 'rails_helper'

RSpec.describe IdeasController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }

  describe '#new' do
    context 'without signed in user' do
      it 'redirect the user to sessions/new page' do
        get :new
        expect(response).to redirect_to(new_session_path)
      end
    end
    context 'with signed in user' do
      before { request.session[:user_id] = user.id }
      it 'renders the new template' do
        get :new
        expect(response).to render_template(:new)
      end
    end
  end
  describe '#create' do
    context 'with user not signed in' do
      it 'redirects to the new session path' do
        post :create, params: { idea: FactoryGirl.attributes_for(:idea) }
        expect(response).to redirect_to(new_session_path)
      end
    end
    context 'with user signed in' do
      before { request.session[:user_id] = user.id }
      context 'with valid parameters' do
        def valid_request
          post :create, params: { idea: FactoryGirl.attributes_for(:idea) }
        end
        it 'creates a new idea in the database' do
          count_before = Idea.count
          valid_request
          count_after = Idea.count
          expect(count_before).to eq(count_after - 1)
        end
        it 'redirects to show page of the idea' do
          valid_request
          expect(response).to redirect_to(idea_path(Idea.last))
        end

        it 'associates the idea with the signed in user' do
          valid_request
          expect(Idea.last.user).to eq(user)
        end
      end
    end

  end
end
