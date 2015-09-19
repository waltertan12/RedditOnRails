# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  validates :title, :author_id, presence: true
  validate  :has_a_sub

  belongs_to :author,
    class_name: "User",
    foreign_key: :author_id,
    primary_key: :id

  has_many :comments
  has_many :post_subs, inverse_of: :post, dependent: :destroy
  has_many :subs, through: :post_subs
  has_many :votes, as: :votable, dependent: :destroy

  def comments_by_parent_id
    result = Hash.new { |h, k| h[k] = [] }
    comments.each do |comment|
      result[comment.parent_comment_id] << comment
    end
    result
  end

  def count_votes
    result = Hash.new(0)
    votes = Vote.where(votable_type: "Post", votable_id: id)
    result[:total] = votes.count

    votes.each do |vote|
      result[:score] += vote.value
    end

    result
  end

  private
  def has_a_sub
    if self.subs.empty?
      errors[:errors] = "must belong to a sub"
    end
  end
end
