class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  scope :star_count, -> {order(confort: :desc)}
  scope :newbook, -> {order(created_at: :desc)}


  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.looks(search, word)
   if search=="perfect_match"
     @book=Book.where("title LIKE?", "#{word}")
   elsif search=="forward_match"
     @book=Book.where("title LIKE?", "#{word}%")
   elsif search=="backword_match"
     @book=Book.where("title LIKE?", "%#{word}")
   elsif search=="partial_match"
     @book=Book.where("title LIKE?", "%#{word}%")
   else
     @book=Book.all
   end
  end

  def self.search(search_word)
    Book.where(["category LIKE?", "#{search_word}"])
  end
end
