class Genre < ActiveHash::Base
  self.data = [
    { id: 1, name: '選択してください' },
    { id: 2, name: '仕事' },
    { id: 3, name: '生活' },
    { id: 4, name: '遊び' },
    { id: 5, name: '移動' },
    { id: 6, name: '学習' },
    { id: 7, name: 'その他' },
  ]

  include ActiveHash::Associations
  has_many :articles

end