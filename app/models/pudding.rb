# == Schema Information
#
# Table name: puddings
#
#  id                 :integer          not null, primary key
#  email              :string           default(""), not null
#  encrypted_password :string           default(""), not null
#  sign_in_count      :integer          default(0), not null
#  current_sign_in_at :datetime
#  last_sign_in_at    :datetime
#  current_sign_in_ip :inet
#  last_sign_in_ip    :inet
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  name               :string
#

class Pudding < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :tournament_players
  has_many :tournaments, through: :tournament_players

  has_many :matches, through: :tournaments
  has_many :results, through: :matches

  has_one :setting, dependent: :destroy
  has_many :post_its

  devise :database_authenticatable, :trackable

  def winning(tournament)
    tournament.pudding_winning == self ? true : false
  end

end
