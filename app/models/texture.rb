class Texture < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: 'サクサク' },
    { id: 3, name: 'カリカリ、カリッと' },
    { id: 4, name: '柔らかい' },
    { id: 5, name: 'もちもち' },
    { id: 6, name: 'ぷにぷに' },
    { id: 7, name: 'ふわふわ、ふっくら' },
    { id: 8, name: 'ツルツル' },
    { id: 9, name: '滑らか' },
    { id: 10, name: 'その他' }
  ]
  include ActiveHash::Associations
  has_many :tweets
  end