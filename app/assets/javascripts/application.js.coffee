###
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require bootstrap-lightbox
###

$ ->
	$.ajaxSetup {
		beforeSend: (xhr) ->
			xhr.setRequestHeader 'X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')
	}
