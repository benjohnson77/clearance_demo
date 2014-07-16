class ClearanceBatchesController < ApplicationController

  def index
    if params[:items]
      clearancing_status =ClearancingService.process_items(params[:items].split(",").map(&:to_i))
      clearance_batch    = clearancing_status.clearance_batch
      alert_messages     = []
      if clearance_batch.persisted?
        flash[:notice]  = "#{clearance_batch.items.count} items clearanced in batch #{clearance_batch.id}"
      else
        alert_messages << "No new clearance batch was added"
      end
      if clearancing_status.errors.any?
        alert_messages << "#{clearancing_status.errors.count} item ids raised errors and were not clearanced"
        clearancing_status.errors.each {|error| alert_messages << error }
      end
      flash[:alert] = alert_messages.join("<br/>") if alert_messages.any?
    end  

    @clearance_batches = ClearanceBatch.all
  end

  def create
    clearancing_status = ClearancingService.process_file(params[:csv_batch_file].tempfile)
    clearance_batch    = clearancing_status.clearance_batch
    alert_messages     = []
    if clearance_batch.persisted?
      flash[:notice]  = "#{clearance_batch.items.count} items clearanced in batch #{clearance_batch.id}"
    else
      alert_messages << "No new clearance batch was added"
    end
    if clearancing_status.errors.any?
      alert_messages << "#{clearancing_status.errors.count} item ids raised errors and were not clearanced"
      clearancing_status.errors.each {|error| alert_messages << error }
    end
    flash[:alert] = alert_messages.join("<br/>") if alert_messages.any?
    redirect_to action: :index
  end

  def show 
    @clearance_batch = ClearanceBatch.find(params[:id])
    @items = Item.where(clearance_batch_id: params[:id])
  end  

end
