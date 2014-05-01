###
//= require jquery
//= require jquery_ujs
//= require_tree .
###

$ ->
	$.ajaxSetup {
		beforeSend: (xhr) ->
			xhr.setRequestHeader 'X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')
	}
