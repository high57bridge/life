class Post < ApplicationRecord
  validates :name, presence: true, length: {minimum:2, maximum:50}
  validates :introduction, presence: true, length: {minimum:2, maximum:200}
  validates :address, presence: true

  has_many :comments, dependent: :destroy  # Post.comments で、その投稿のコメント取得
  has_many :replies, class_name: "Comment", foreign_key: :reply_comment, dependent: :destroy

  has_many :likes, dependent: :destroy
  def liked_by?(customer)
    likes.exists?(customer_id: customer)
  end

  has_many :reads, dependent: :destroy

  has_many :hashtags, dependent: :destroy
  has_many :tags, through: :hashtags

  after_create do
    post = Post.find_by(id: id)
    # hashbodyに打ち込まれたハッシュタグを検出
    tags = introduction.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    tags.uniq.map do |tag|
      # ハッシュタグは先頭の#を外した上で保存
      tag = Tag.find_or_create_by(name: tag.downcase.delete('#'))
      post.tags << tag
    end
  end
  #更新アクション
  before_update do
    post = Post.find_by(id: id)
    post.tags.clear
    tags = introduction.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    tags.uniq.map do |tag|
      tag = Tag.find_or_create_by(name: tag.downcase.delete('#'))
      post.tags << tag
    end
  end
  
                              <style>
                                #map {
                                  height: 400px;
                                  width: 500px;
                                }
                            </style>

                            <script>
                                let map
                                let geocoder

                                const display = document.getElementById('display')

                                function initMap(){
                                  geocoder = new google.maps.Geocoder(),

                                  map = new google.maps.Map(document.getElementById('map'), {
                                    // latが緯度、lngが経度を示します
                                    center: {lat: 40.7828, lng:-73.9653},
                                    //数値は0〜21まで指定できます。数値が大きいほど拡大されます
                                    zoom: 10,
                                  });
                                  //positionに指定した座標にピンを表示させます
                                  marker = new google.maps.Marker({
                                    position:  {lat: 40.7828, lng:-73.9653},
                                    map: map
                                  });
                                }

                                  //検索フォームのボタンが押された時に実行される
                                function codeAddress(){
                                  //検索フォームの入力内容を取得
                                  let inputAddress = document.getElementById('address').value;

                                  geocoder.geocode( { 'address': inputAddress}, function(results, status) {
                                    //該当する検索結果がヒットした時に、地図の中心を検索結果の緯度経度に更新する
                                    if (status == 'OK') {
                                      map.setCenter(results[0].geometry.location);
                                      var marker = new google.maps.Marker({
                                          map: map,
                                          position: results[0].geometry.location
                                      });
                                      display.textContent = "検索結果：" + results[ 0 ].geometry.location
                                    } else {
                                      //検索結果が何もなかった場合に表示
                                      alert('該当する結果がありませんでした：' + status);
                                    }
                                  });
                                }
                            </script>
                            <script src="https://maps.googleapis.com/maps/api/js?key=<%= ENV["GOOGLE_API_KEY"] %>&callback=initMap" async defer></script>


# 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @post = Post.where("name LIKE? or introduction LIKE? or address LIKE?","%#{word}%", "%#{word}%", "%#{word}%")
    elsif search == "partial_match"
      @post = Post.where("name LIKE? or introduction LIKE? or address LIKE?","%#{word}%", "%#{word}%", "%#{word}%")
    else
      @post = Post.all
    end
  end

end
