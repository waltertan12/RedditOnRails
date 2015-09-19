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

  # belongs_to :sub,
  #   class_name: "Sub",
  #   foreign_key: :sub_id,
  #   primary_key: :id
  has_many :comments
  has_many :post_subs, inverse_of: :post, dependent: :destroy
  has_many :subs, through: :post_subs

  private
  def has_a_sub
    if self.subs.empty?
      errors[:errors] = "must belong to a sub"
    end
  end
end
