FactoryGirl.define do

  factory :clearance_batch do
    
  end

  factory :item do
    style 
    color { Faker::Commerce.color }
    size  { ["S", "M", "L", "XL"].sample }
    status { ["sellable", "not sellable", "sold", "clearanced"].sample }
  end

  factory :style do
    name { Faker::Commerce.product_name }
    wholesale_price { Faker::Commerce.price }
  end
end
