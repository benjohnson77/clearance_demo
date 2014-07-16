# == Schema Information
#
# Table name: clearance_batches
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#

class ClearanceBatch < ActiveRecord::Base

  has_many :items

end
