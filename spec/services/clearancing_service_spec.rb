require 'rails_helper'

describe ClearancingService do

  describe "::process_file" do

    context "total success" do

      it "should parse a CSV file to create a clearance_batch with all the items clearanced" do
        items              = 5.times.map{ FactoryGirl.create(:item , status: 'sellable') }
        file_name          = generate_csv_file(items)
        uploaded_file      = Rack::Test::UploadedFile.new(file_name)
        clearancing_status = ClearancingService::process_file(uploaded_file)
        clearance_batch    = clearancing_status.clearance_batch
        expect(clearancing_status.errors.empty?).to be true
        expect(clearance_batch.items.pluck(:id)).to eq(items.map(&:id))
        expect(clearance_batch.items.pluck(:status).uniq).to eq(["clearanced"])
      end

    end

    context "partial success" do

      it "should parse a CSV file to create a clearance_batch with some the items clearanced" do
        valid_items        = 3.times.map{ FactoryGirl.create(:item, status: 'sellable') }
        invalid_items      = [[987654], ['no thanks']]
        file_name          = generate_csv_file(valid_items + invalid_items)
        uploaded_file      = Rack::Test::UploadedFile.new(file_name)
        clearancing_status = ClearancingService::process_file(uploaded_file)
        clearance_batch    = clearancing_status.clearance_batch
        expect(clearancing_status.errors.count).to eq(invalid_items.count)
        #expect(clearance_batch.items.pluck(:id)).to eq(valid_items.map(&:id))
      end

    end

    context "total failure" do

      it "should parse a CSV file to not create a clearance_batch" do
        invalid_items      = [[987654], ['no thanks']]
        file_name          = generate_csv_file(invalid_items)
        uploaded_file      = Rack::Test::UploadedFile.new(file_name)
        clearancing_status = ClearancingService::process_file(uploaded_file)
        clearance_batch    = clearancing_status.clearance_batch
        expect(clearance_batch).to be_new_record
        expect(clearancing_status.errors.count).to eq(invalid_items.count)
      end

    end

  end

  describe "::clearance_items" do

    it "should process all the item ids and add them to the clearance_batch" do
      clearancing_status  = ClearancingService::create_clearancing_status
      item_ids            = 5.times.map{ FactoryGirl.create(:item).id }
      clearancing_status.item_ids_to_clearance  = item_ids 
      expect {
        @new_clearancing_status  = ClearancingService::clearance_items(clearancing_status)
      }.to change(ClearanceBatch, :count)
      expect(Item.all.map(&:clearance_batch_id).uniq).to eq([@new_clearancing_status.clearance_batch.id])
    end
  end

  describe "::what_is_the_clearancing_error" do

    it "should return nil if there are no errors" do
        valid_item  = FactoryGirl.create(:item)
        expect(ClearancingService::what_is_the_clearancing_error(valid_item.id)).to be_nil
    end

    context "there are errors" do

      it "the item cannot be found" do
        invalid_item_id = 987654
        expect(ClearancingService::what_is_the_clearancing_error(invalid_item_id)).to eq("Item id #{invalid_item_id} could not be found")
      end

      it "the item is not sellable" do
        unsellable_item  = FactoryGirl.create(:item, status: 'sold')
        expect(ClearancingService::what_is_the_clearancing_error(unsellable_item.id)).to eq("Item with id #{unsellable_item.id} could not be clearanced")
      end

      it "the item id is not valid" do
        ['this', '', nil, 123.45].each do |invalid_item_id|
          expect(ClearancingService::what_is_the_clearancing_error(invalid_item_id)).to eq("Item id #{invalid_item_id} is not valid")
        end
      end

    end

  end


end
