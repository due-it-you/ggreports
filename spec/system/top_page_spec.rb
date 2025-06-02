require 'rails_helper'

RSpec.describe 'トップページ', type: :feature do
  context '英語圏から"/"にアクセスがあった場合' do
    it '"/en/lol"にリダイレクトされる' do
      page.driver.header 'Accept-Language', 'en'
      visit root_path
      expect(current_path).to eq('/en/lol')
    end
  end

  context '日本語圏から"/"にアクセスがあった場合' do
    it '"/ja/lol"にリダイレクトされる' do
      page.driver.header 'Accept-Language', 'ja'
      visit root_path
      expect(current_path).to eq('/ja/lol')
    end
  end

  context '許可されていない言語からアクセスがあった場合' do
    it 'デフォルトのリダイレクト先として設定されている/en/lolにリダイレクトされる' do
      page.driver.header 'Accept-Language', 'nil'
      visit root_path
      expect(current_path).to eq('/en/lol')
    end
  end
end