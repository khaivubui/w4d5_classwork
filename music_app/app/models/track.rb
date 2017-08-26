# == Schema Information
#
# Table name: tracks
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  ord        :integer          not null
#  lyrics     :text
#  track_type :string           default("regular")
#  album_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Track < ApplicationRecord
  validates :title, :ord, :album_id, presence: true
  validates :track_type,
            presence: true,
            inclusion: {
              in: %w(regular bonus),
              message: "%{value} is not a valid type"
            }

  belongs_to :album

  has_one :band,
          through: :album
end
