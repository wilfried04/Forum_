#bundle exec rspec spec/system/topic_spec.rb

require 'rails_helper'
require 'selenium-webdriver'
require 'capybara'

RSpec.describe 'topic Management Function', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:second_user)
  end

  describe 'startup registration screen' do
    context 'When you fill in the required fields and press the create button' do
      it 'Data is stored.' do
        visit new_user_session_path
        fill_in 'user[email]', with: @user.email
        fill_in 'user[password]', with: @user.password
        click_button 'Log in'
        visit new_topic_path
        select 'Loisir', from: 'topic[category]'
        fill_in 'topic[title]', with: "topic1"
        fill_in 'topic[content]', with: 'Sed ut perspiciatis unde
          omnis iste natus error sit voluptatem
          accusantium doloremque laudantium,
          totam rem aperiam, eaque ipsa quae ab illo
          inventore veritatis et quasi architecto beatae
           vitae dicta sunt explicabo. Nemo enim ipsam
           voluptatem quia voluptas sit aspernatur au'
        click_on 'commit'
        expect(page).to have_content 'topic1'
      end
    end
    context 'when user fill wrong field' do
      it 'can not create startup without name, resume, adresse, sector_of_business, contact' do
        visit new_user_session_path
        fill_in 'user[email]', with: @user.email
        fill_in 'user[password]', with: @user.password
        click_button 'Log in'
        visit new_topic_path
        click_on 'commit'
        expect { raise StandardError, "Title can't be blank"}.to raise_error("Title can't be blank")
        expect { raise StandardError, "Content can't be blank"}.to raise_error("Content can't be blank")
      end
    end
    context 'when user had event' do
      it 'can  create another startup' do
        FactoryBot.create(:topic, user: @user)
        visit new_user_session_path
        fill_in 'user[email]', with: @user.email
        fill_in 'user[password]', with: @user.password
        click_button 'Log in'
        visit new_topic_path
        select 'Loisir', from: 'topic[category]'
        fill_in 'topic[title]', with: "topic2"
        fill_in 'topic[content]', with: 'Sed ut perspiciatis unde
          omnis iste natus error sit voluptatem
          accusantium doloremque laudantium,
          totam rem aperiam, eaque ipsa quae ab illo
          inventore veritatis et quasi architecto beatae
           vitae dicta sunt explicabo. Nemo enim ipsam
           voluptatem quia voluptas sit aspernatur au'
        click_on 'commit'
        expect(page).to have_content 'topic2'
      end
    end
  end
    describe 'search function' do
      context 'If user search by name' do
        it 'You can search by name.' do
          FactoryBot.create(:topic, user: @user)
          visit new_user_session_path
          fill_in 'user[email]', with: @user.email
          fill_in 'user[password]', with: @user.password
          click_button 'Log in'
          expect(page).to have_content 'topic1'
        end
      end
      context 'If user search by categories / category' do
        it 'You can search by name.' do
          FactoryBot.create(:topic, user: @user)
          visit new_user_session_path
          fill_in 'user[email]', with: @user.email
          fill_in 'user[password]', with: @user.password
          click_button 'Log in'
          visit new_topic_path
          select 'Actualité', from: 'topic[category]'
          fill_in 'topic[title]', with: "topic2"
          fill_in 'topic[content]', with: 'Sed ut perspiciatis unde
            omnis iste natus error sit voluptatem
            accusantium doloremque laudantium,
            totam rem aperiam, eaque ipsa quae ab illo
            inventore veritatis et quasi architecto beatae
             vitae dicta sunt explicabo. Nemo enim ipsam
             voluptatem quia voluptas sit aspernatur au'
          click_on 'commit'
          click_link 'Loisir'

          expect(page).to have_content 'topic1'
        end
      end
      context ' Favorite fonction' do
        it 'You can like topic.' do
          FactoryBot.create(:topic, user: @user)
          FactoryBot.create(:topic, user: @user2)

          visit new_user_session_path
          fill_in 'user[email]', with: @user2.email
          fill_in 'user[password]', with: @user2.password
          click_button 'Log in'
          click_link("comment", :match => :first)
          click_link 'Like'

          expect(page).to have_content 'unlike'
        end
      end
    end
end
