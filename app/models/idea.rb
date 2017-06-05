class Idea < ApplicationRecord
  belongs_to :user, optional: true

  validates :title, presence: true,
                    uniqueness: { case_sensitive: false}
  validates :description, presence: true,
                          length: {minimum: 10}

  after_initialize :set_defaults

  private

  def set_defaults
    self.like_count ||= 1
    self.member_count ||= 1
  end

end
