# == Schema Information
#
# Table name: items
#
#  id                 :integer          not null, primary key
#  size               :string(255)
#  color              :string(255)
#  status             :string(255)
#  price_sold         :decimal(, )
#  sold_at            :datetime
#  style_id           :integer
#  created_at         :datetime
#  updated_at         :datetime
#  clearance_batch_id :integer
#

class Item < ActiveRecord::Base

  CLEARANCE_PRICE_PERCENTAGE  = BigDecimal.new("0.75")
  MIN_CLEARANCE_PANTS_DRESSES = 5
  MIN_CLEARANCE = 2
  STATUS = ["sellable", "not sellable", "sold", "clearanced"]

  belongs_to :style
  belongs_to :clearance_batch
  scope :sellable, -> { where(status: "sellable") }

  def perform_clearance
    price_sold  = style.wholesale_price * BigDecimal.new(CLEARANCE_PRICE_PERCENTAGE)
    min_price = ["pants","dresses"].include?(style.type) ? MIN_CLEARANCE_PANTS_DRESSES : MIN_CLEARANCE 		
    update_attributes!(status: "clearanced", price_sold: [price_sold,min_price].max, sold_at: Time.zone.now)
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |item|
        csv << item.attributes.values_at(*column_names)
      end
    end    
  end

end
