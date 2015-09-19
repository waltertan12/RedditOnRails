class Vote < ActiveRecord::Base
  validates :votable_id, :votable_type, :value, presence: true
  validates :value, inclusion: { in: [-1, 1] }
  validates :votable_id, uniqueness: {scope: [:user_id, :votable_type]}

  belongs_to :votable, polymorphic: true
end
