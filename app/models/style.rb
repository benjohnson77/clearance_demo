# == Schema Information
#
# Table name: styles
#
#  id              :integer          not null, primary key
#  wholesale_price :decimal(, )
#  retail_price    :decimal(, )
#  type            :string(255)
#  name            :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

class Style < ActiveRecord::Base
  self.inheritance_column = :_type_disabled
  
  has_many :items, :class_name => 'Item', :foreign_key => 'style_id'

end
