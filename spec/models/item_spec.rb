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

require 'rails_helper'

describe Item do


  describe "#perform_clearance" do

    it "should mark the item status as clearanced" do
      item  = FactoryGirl.create(:item)
      item.perform_clearance
      expect(item.status).to eq("clearanced")
    end

    it "should set the price_sold as CLEARANCE PRICE PERCENTAGE of the wholesale_price" do
      style = FactoryGirl.create(:style, wholesale_price: 100)
      item  = FactoryGirl.create(:item, style: style)
      item.perform_clearance
      expect(item.price_sold).to eq(BigDecimal.new("100") * Item::CLEARANCE_PRICE_PERCENTAGE)
    end

    it "should should never be less then min price" do
      style = FactoryGirl.create(:style, wholesale_price: 2.20, type: "shirts")
      item  = FactoryGirl.create(:item, style: style)
      item.perform_clearance
      expect(item.price_sold).to eq(Item::MIN_CLEARANCE)
    end

    context "pants and dresses" do
      it "pants should never be less then 5" do
        style = FactoryGirl.create(:style, wholesale_price: 5.10, type: "pants")
        item  = FactoryGirl.create(:item, style: style)
        item.perform_clearance
        expect(item.price_sold).to eq(5)
      end

      it "dresses should never be less then 5" do
        style = FactoryGirl.create(:style, wholesale_price: 5.10, type: "dresses")
        item  = FactoryGirl.create(:item, style: style)
        item.perform_clearance
        expect(item.price_sold).to eq(5)
      end
    end



  end

end
