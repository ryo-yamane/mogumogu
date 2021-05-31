class Company < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: 'ブルボン' },
    { id: 3, name: '森永' },
    { id: 4, name: 'Grico' },
    { id: 5, name: 'セコイヤ' },
    { id: 6, name: '株式会社やおきん' },
    { id: 7, name: '丸川製菓' },
    { id: 8, name: 'トップ製菓株式会社' },
    { id: 9, name: 'オリオン株式会社' },
    { id: 10, name: 'チロルチョコ株式会社' },
    { id: 11, name: '丹生堂' },
    { id: 12, name: 'よちゃん食品株式会社' },
    { id: 13, name: '株式会社おやつカンパニー' },
    { id: 14, name: '株式会社赤木乳業' },
    { id: 15, name: 'Lotte' },
    { id: 16, name: '共親製菓' },
    { id: 17, name: 'その他' }
  ]
  include ActiveHash::Associations
  has_many :tweets
end
