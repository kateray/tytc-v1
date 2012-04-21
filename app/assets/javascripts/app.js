jQuery(function($){

	$('#flash_error').each(function(){
		$(this).delay(2000);
		$(this).slideUp('fast');
	})
	
	//tktk prob shouldn't be a global variable - when i set it on AppView doesn't work tho
	window.contributing = false;

	window.AppView = Backbone.View.extend({
		events : {
			"focus #new_link_form input" : "contributingOn"
		},

		initialize : function(){
			_.bindAll(this);
			this.contributingOff();
		},

		contributingOn : function(){
			contributing = true;
			this.trigger('contributingOn');
			$('#contributing_mode').slideDown('fast');
			$('#links_container').animate({
				opacity : 0.4
			}, 300);
			$('#links_container').bind('click.contributingOff', this.contributingOff)
		},
		
		contributingOff : function(){
			contributing = false;
			this.trigger('contributingOff');
			$('.invalid').removeClass('invalid');
			$('#contributing_mode').slideUp('fast');
			$('.contributing_tick').attr("checked", null).hide();
			$('#links_container').animate({
				opacity : 1
			}, 300);
			$('#links_container').unbind('click.contributingOff');
			$('#new_link_tags').html('');
		}
	})

	window.App = new AppView({el : $(window)});
	
	window.Vote = Backbone.Model.extend({
		
	})
	
	window.VoteList = Backbone.Collection.extend({
		model : Vote,
		url : '/votes'
	})
	
	window.Votes = new VoteList;
	
})