jQuery(function($){
	var first = true;
	window.Link = Backbone.Model.extend({
		defaults : {
			"votes_count" : 0,
			"comments_count" : 0
		},

		validate : function(attrs){
			var errors = [];
			if (!attrs.title || attrs.title.length < 3) {
				$('input[id="link_title"]').addDefaultText('Please enter a title').addClass('invalid');
				errors.push("Title can't be blank");
			}
			if (!attrs.url || validateURL(attrs.url) == false){
				$('input[id="link_url"]').addDefaultText('Please enter a valid url').addClass('invalid');
				errors.push("Bad url");
			}
			if (_.isEmpty(attrs.taggings)) {
				errors.push("missing tags");
			}
			return _.any(errors) ? errors : null;
		},

		initialize : function(){
			_.bindAll(this);
		},

		voteUp : function(){
			if (this.get("has_voted") == 'false'){
				Votes.create({link_id : this.get("id")});
				this.set({votes_count : this.get("votes_count")+1, has_voted : 'true'});
			}
		},

		showLinkView : function(){
			var view = new LinkShowView({model : this});
			$('#linkShow').append(view.render().el);
			if (first == true){
				first = false;
				$('#linkShow_container').show();
				$('#linkList').hide();
			} else {
				$('#linkShow_container').show('slide', {direction : 'right'});
				$('#linkList').hide('slide', {direction : 'left'});
			}
		}
	})
		
	window.LinkList = Backbone.Collection.extend({
		model : Link,
		url : '/links',
		initialize : function(){
			this.addTags = new Array();
			this.queryParams = new Array();
		},
		
		query : function(){
			var params = {};
			params['tags'] = this.queryParams;
			this.fetch({ data : params});
		}
	})
	
	window.Links = new LinkList;
	
	window.LinkView = Backbone.View.extend({
		
		events : {
			// "click .vote_button" : "voteUp"
		},
		
		initialize : function(){
			_.bindAll(this);

			var that = this;

			this.$('.vote_button').live('click', this.model.voteUp);
			
			this.$('.link_comments').live('click', function(event){
				if ($('#linkList').data('page') == 'links') {
					event.preventDefault();
					History.pushState({id : that.model.get("id")}, null, '/links/'+that.model.get("id"));
				}
			})
			this.model.bind('change', this.render);
			this.model.bind('destroy', this.remove);
		},
		
		render : function(){
			$(this.el).html($('#linkTemplate').tmpl(this.model.toJSON()));
			if (this.model.get('has_voted') == 'true') this.$('.vote_button').css('opacity', '0')
			else this.$('.vote_button').css('border-bottom-color', '#e5432f')
			return this;
		},
		
		remove : function(){
			$(this.el).remove();
		}
	})
	
	window.LinkShowView = Backbone.View.extend({

		initialize : function(){
			_.bindAll(this);
			this.$('.vote_button').live('click', this.model.voteUp);

			this.model.bind('change', this.render);
		},
		
		render : function(){
			App.contributingOff();
			$(this.el).html($('#linkShowTemplate').tmpl(this.model.toJSON()));
			if (this.model.get('has_voted') == 'true') this.$('.vote_button').css('opacity', '0')
			else this.$('.vote_button').css('border-bottom-color', '#e5432f')
			new CommentListView({
				el : this.$('#commentListView'),
				link_id : this.model.get("id")
			});
			return this;
		}
	})
	
	window.LinkListView = Backbone.View.extend({
		initialize : function(){
			_.bindAll(this);
			
			Links.bind('add', this.addOne);
			Links.bind('reset', this.addAll);
			App.bind('contributingOn', this.contributingOn);
			App.bind('contributingOff', this.contributingOff);
			$(window).bind('popstate', this.reload);
			
			this.show_id = null;
			this.contributingOff();
			$('form[id="new_link"]').find('input, textarea').addDefaultText();
			$('form[id="new_link"]').submit(this.createLink);
			$('form[id="new_link"]').ajaxError(function(e, jqXHR, settings, exception){
				showError(jqXHR.responseText);
				App.contributingOn()
				$(this).resetForm();
			})
			$('#show_index').click(function(){
				History.pushState(null, null, '/');
			});
		},
		
		createLink : function(event){
			event.preventDefault();
			var formData = $('form[id="new_link"]').serializeForm();
			if (!formData['url'].match(/^https?:\/\//)) formData['url'] = 'http://' + formData['url']
			$('.invalid').removeClass('invalid');
			//TKTK should be a validation
			var left = $('.left_container').filter(function(index) {
				return $(this).find('.contributing_tick:checked').length == 0;
			})
			if (left.length){
				left.addClass('invalid');
				var taggings = [];
			} else {
				var taggings = Links.addTags;
			}
			formData['taggings'] = taggings;
			var newLink = Links.create(formData, {wait: true});
			return false;
		},
		
		reload : function(){
			var state = History.getState();
			if (state.data['id']){
				Links.get(state.data['id']).showLinkView();
			} else {
				this.showIndex();
			}
		},
		
		showIndex : function(){
			//tktk this is a bad way of finding whether to query
			if ($('#linkList').find('.link_container').length < 2) Links.query()
			if (first == true){
				first = false;
				$('#linkShow_container').hide();
				$('#linkList').show();
				$('#linkShow').html('');
			} else {
				$('#linkList').show('slide', {direction : 'left'});
				$('#linkShow_container').hide('slide', {direction : 'right'}, 400, function(){
					$('#linkShow').html('');
				});
			}
		},
		
		addOne : function(link){
			var view = new LinkView({model : link});
			$(this.el).append(view.render().el)
			if (contributing) App.contributingOff()
		},
		
		addAll : function(){
			$(this.el).html('');
			Links.each(this.addOne);
		},

		contributingOn : function(){
			$('form[id="new_link"]').find('button').removeAttr('disabled');
			$('.contributing_tick').attr('checked', false).show();
			Links.addTags = [];
			$('#new_link_tags').html('');
		},

		contributingOff : function(){
			$('form[id="new_link"]').find('button').attr('disabled', 'disabled');
		}
		
	})
	
	
	new LinkListView({el : '#linkList'});
});