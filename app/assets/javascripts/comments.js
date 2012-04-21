jQuery(function($){
	window.Comment = Backbone.Model.extend({
		validate : function(attrs){
			var errors = [];
			if (!attrs.content || attrs.content.length == 0) {
				$('textarea[id="comment_content"]').addDefaultText('Please enter a valid comment').addClass('invalid');
				errors.push("Comment can't be blank");
			}
			return _.any(errors) ? errors : null;
		}
	})
	
	window.CommentList = Backbone.Collection.extend({
		model : Comment,
		url : '/comments'
		
	})
	
	window.Comments = new CommentList();
	
	window.CommentView = Backbone.View.extend({
		initialize : function(){
			_.bindAll(this);
			
			this.model.bind('change', this.render);
			this.model.bind('destroy', this.remove);
		},
		
		render : function(){
			$(this.el).html($('#commentTemplate').tmpl(this.model.toJSON()));
			return this;
		},
		
		remove : function(){
			$(this.el).remove();
		}
	})
	
	window.CommentListView = Backbone.View.extend({
		
		initialize : function(options){
			_.bindAll(this);
			Comments.bind('create')
			Comments.bind('add', this.addOne);
			Comments.bind('reset', this.addAll);
			App.bind('contributingOn', this.contributingOn);
			App.bind('contributingOff', this.contributingOff);
			
			this.input = this.$('#new_comment');
			this.link_id = options.link_id;

			Comments.fetch({data : {link_id : this.link_id} });
			this.contributingOff();
			this.$('textarea[id="comment_content"]').addDefaultText('Write a comment');
			this.$('form[id="new_comment"]').submit(this.create)
		},
		
		addOne : function(comment){
			
			var view = new CommentView({model : comment});
			this.$('#commentList').prepend(view.render().el);
		},
		
		addAll : function(){
			Comments.each(this.addOne);
		},
		
		create : function(event){
			event.preventDefault();
			var formData = $('form[id="new_comment"]').serializeForm();
			Comments.create(formData);
			$('form[id="new_comment"]').resetForm();
			return false;
		},

		contributingOn : function(){
			this.$('textarea, input, button').attr('disabled', 'disabled');
		},

		contributingOff : function(){
			this.$('textarea, input, button').removeAttr('disabled');
		}


	})

})