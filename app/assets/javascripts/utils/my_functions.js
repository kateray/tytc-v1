(function($){

	$.fn.serializeForm = function(){
	    var o = {};
	    $(this).find('textarea, input').each(function(){
	    	if ($(this).val() == $(this).data('default')) $(this).val('')
	    })
	    var a = this.serializeArray();
	    $.each(a, function() {
	    	if (this.name.match(/\[.+\]/)) this.name = this.name.match(/\[(.+)\]/)[1]
	        if (o[this.name] !== undefined) {
	            if (!o[this.name].push) {
	                o[this.name] = [o[this.name]];
	            }
	            o[this.name].push(this.value || '');
	        } else {
	            o[this.name] = this.value || '';
	        }
	    });
	    return o;
	};
	$.fn.resetForm = function(){
		$(this)[0].reset();
		$(this).find('textarea, input').each(function(){
	    	$(this).val($(this).data('default')).addClass('default_text')
	    })
	}
})(jQuery);

var showError = function(string){
	$('#jsError').html(string).slideDown('fast').delay(4000).slideUp('fast');
}

var validateURL = function(url){
	var url_format = /^((http|https|ftp)\:\/\/)*([a-zA-Z0-9\.\-]+(\:[a-zA-Z0-9\.&amp;%\$\-]+)*@)*((25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])|([a-zA-Z0-9\-]+\.)*[a-zA-Z0-9\-]+\.(com|edu|gov|int|mil|net|org|biz|arpa|info|name|pro|aero|coop|museum|[a-zA-Z]{2}))(\:[0-9]+)*(\/($|[a-zA-Z0-9\.\,\?\'\\\+&amp;%\$#\=~_\-]+))*$/;
	if (url_format.test(url) == false) return false
	else return true
}
