class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: 'チョコレート' },
    { id: 3, name: '魚介乾製品' },
    { id: 4, name: 'ガム' },
    { id: 5, name: 'ラムネ' },
    { id: 6, name: '砂糖菓子' },
    { id: 7, name: 'ゼリー' },
    { id: 8, name: 'インスタント麺' },
    { id: 9, name: 'アイスクリーム' },
    { id: 10, name: 'その他' }
  ]

  include ActiveHash::Associations
  has_many :tweets
  end