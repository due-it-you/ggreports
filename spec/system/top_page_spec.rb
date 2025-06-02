require 'rails_helper'

RSpec.describe 'トップページ', type: :feature do
  context '英語圏から"/"にアクセスがあった場合' do
    it '"/en/lol"にリダイレクトされる' do
      page.driver.header 'Accept-Language', 'en'
      visit root_path
      expect(current_path).to eq("/en/lol")
    end
  end
end