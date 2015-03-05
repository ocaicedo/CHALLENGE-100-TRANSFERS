# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string
#  balance    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
	has_many :sent_transfers, class_name: :Transfer, foreign_key: :sender_id
	has_many :received_transfers, class_name: :Transfer, foreign_key: :receiver_id
end
