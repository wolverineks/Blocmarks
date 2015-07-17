class Topic < ActiveRecord::Base
  belongs_to :user
  has_many :bookmarks

  def to_s
    # custom
  end
end
