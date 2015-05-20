require 'spec_helper'

# 静的なサイトをテストするためのコード
# サイト上に指定の文字列があるかどうかをチェックしている

describe "Static pages" do

  let(:base_title) { "Ruby on Rails Tutorial Sample App"}

  describe "Home page" do

      it "should have the content 'Sample App'" do
          visit '/static_pages/home'
          expect(page).to have_content('Sample App')
      end

      it "should have the base_title" do
        visit '/static_pages/home'
        expect(page).to have_title("#{base_title}")
      end

      it "should not have a custom page title" do
        visit '/static_pages/home'
        expect(page).not_to have_title('| Home')
      end
  end

  describe "Help page" do

      it "should have the content 'Help'" do
        visit '/static_pages/help'
        expect(page).to have_content('Help')
      end

      it "should have the base_title" do
        visit '/static_pages/help'
        expect(page).to have_title("#{base_title}")
      end

      it "should not have a custom page title" do
        visit '/static_pages/help'
        expect(page).not_to have_title('| help')
      end

  end

  describe "About page" do

      it "should have the content 'About us'" do
        visit '/static_pages/about'
        expect(page).to have_content('About us')
      end

      it "should have the base_title" do
        visit '/static_pages/about'
        expect(page).to have_title("#{base_title}")
      end
      
      it "should not have a custom page title" do
        visit '/static_pages/about'
        expect(page).not_to have_title('| About')
      end

  end

  describe "Contact page" do

      it "should have the base_title" do
        visit '/static_pages/contact'
        expect(page).to have_title("#{base_title}")
      end

      it "should not have a custom page title" do
        visit '/static_pages/contact'
        expect(page).not_to have_title('| Contact')
      end
  end
end
