require 'csv'
require 'ostruct'
class ClearancingService

  def self.process_file(uploaded_file)
    clearancing_status      = create_clearancing_status
    CSV.foreach(uploaded_file, headers: false) do |row|  
      potential_item_id = row[0].to_i
      clearancing_error = what_is_the_clearancing_error(potential_item_id)
      if clearancing_error
        clearancing_status.errors << clearancing_error
      else
        clearancing_status.item_ids_to_clearance << potential_item_id
      end
    end

    clearance_items(clearancing_status) 
  end

  def self.process_items(items)
    clearancing_status      = create_clearancing_status
    items.each do |i|  
      potential_item_id = i.to_i
      clearancing_error = what_is_the_clearancing_error(potential_item_id)
      if clearancing_error
        clearancing_status.errors << clearancing_error
      else
        clearancing_status.item_ids_to_clearance << potential_item_id
      end
    end
    clearance_items(clearancing_status) 
  end  

  def self.clearance_items(clearancing_status)
    if clearancing_status.item_ids_to_clearance.any? 
      clearancing_status.clearance_batch.save!
      clearancing_status.item_ids_to_clearance.each do |item_id|
        item  = Item.find(item_id)
        item.perform_clearance
        clearancing_status.clearance_batch.items << item
      end
    end
    clearancing_status
  end

  def self.what_is_the_clearancing_error(potential_item_id)

    if potential_item_id.blank? || potential_item_id == 0 || !potential_item_id.is_a?(Integer)
      return "Item id #{potential_item_id} is not valid"      
    end
    if Item.where(id: potential_item_id).none?
      return "Item id #{potential_item_id} could not be found"      
    end
    if Item.sellable.where(id: potential_item_id).none?
      return "Item with id #{potential_item_id} could not be clearanced"
    end

    return nil
    
  end

  def self.create_clearancing_status
    OpenStruct.new(
      clearance_batch: ClearanceBatch.new,
      item_ids_to_clearance: [],
      errors: [])
  end

end
