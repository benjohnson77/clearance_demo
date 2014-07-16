// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery
//= require bootstrap-sprockets
//= require_tree .

$(document).ready(function($){

  $('#styles').on("click", ".row-toggle", function() {
  	$(this).next().toggle();
  });

   var item_a = $('#items').data('items', []);
   $('#items').on("click", ".ad-batch", function() { 
		var item_a = $('#items').data('items');
		var id = $(this).attr("id").replace('item-','');
		
		if ( $.inArray( id, item_a ) >= 0 ){

			item_a.splice($.inArray( id , item_a ), 1 );
			$('#items').data('items', item_a);
			$(this).parents('tr').removeClass('info');

			//alert(item_a);
		}else{	
			$('#items').data('items').push(id);
			$(this).parents('tr').addClass('info');	
		
			//alert(item_a);
		}

  	});

   	$('#items').on("click", ".batch-me", function() { 
		var item_a = $('#items').data('items')
		//alert(item_a);
		document.location.href = "/clearance_batches?items="+item_a
	}); 
}); 
