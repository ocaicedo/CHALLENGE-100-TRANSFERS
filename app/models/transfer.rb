# == Schema Information
#
# Table name: transfers
#
#  id          :integer          not null, primary key
#  sender_id   :integer
#  receiver_id :integer
#  amount      :decimal(, )
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Transfer < ActiveRecord::Base
	
	after_create  :actualizar_balances_create
	before_update  :actualizar_balances_update
	before_destroy :actualizar_balances_destroy
	
	belongs_to :sender, class_name: :User
	belongs_to :receiver, class_name: :User


	
	def actualizar_balances_create
	  	self.sender.balance = self.sender.balance - self.amount
	 	self.receiver.balance = self.receiver.balance + self.amount
	 	self.sender.save
	 	self.receiver.save
	end

	def actualizar_balances_update
		self.sender.balance = self.sender.balance + self.amount_was
		self.sender.balance = self.sender.balance - self.amount
		self.receiver.balance = self.receiver.balance - self.amount_was
		self.receiver.balance = self.receiver.balance + self.amount
		self.receiver.save
		self.sender.save
	end
	
	def actualizar_balances_destroy
		self.sender.balance = self.sender.balance + self.amount
		self.receiver.balance = self.receiver.balance - self.amount
		self.sender.save
		self.receiver.save
	end
end

