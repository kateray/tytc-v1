jQuery(function($){
	window.Tag = Backbone.Model.extend({
		validate : function(attrs){
			var errors = [];
      if (!attrs.name || attrs.name.length > 15) {
        $('.left_container[data-group="'+attrs.group+'"]').find('.tag_error').text('Tag already exists!').show().delay(1400).fadeOut('slow', function(){
          $(this).text('');
        })
        errors.push("Tag is too long");
      }
      if (Tags.where({name : attrs.name}).length > 0 && Tags.where({name : attrs.name})[0].cid != this.cid){
        $('.left_container[data-group="'+attrs.group+'"]').find('.tag_error').text('Tag already exists!').show().delay(1400).fadeOut('slow', function(){
          $(this).text('');
        })
				errors.push("Tag exists");
			}
			return _.any(errors) ? errors : null;
		}
	})
	
	window.TagList = Backbone.Collection.extend({
		model : Tag,
		url : '/tags',
		comparator : function(tag){
			if (tag.get("group") == "Level") {
				var time = new Date(tag.get("time")*1000);
				return time;
			}
			else return -tag.get("links_count");
		}
	})
	
	window.Tags = new TagList;

	window.Tagging = Backbone.Model.extend({
		
	})
	
	window.TaggingList = Backbone.Collection.extend({
		model : Tagging,
		url : '/taggings'
	})
	
	window.Taggings = new TaggingList;

	window.TagView = Backbone.View.extend({		
		events : {
			// "click" : "toggle",
			"change .contributing_tick" : "addTag"
		},
		
		initialize : function(){
			_.bindAll(this);
			$(this.el).live('click', this.toggle)
			this.model.bind('change', this.render);
			
		},
		
		render : function(){
			$(this.el).html($('#tagTemplate').tmpl(this.model.toJSON()));
			if (contributing == true) {
				this.$('.contributing_tick').show()
			}
			return this;
		},

		addTag : function(){
			if (contributing == true){
				if (this.$('.contributing_tick').is(":checked")){
					$('#new_link_tags').append('<div class = "link_tag" data-id='+this.model.get("id")+'>'+this.$('.tag_option').html()+'</div>');
					Links.addTags.push(this.model.get("id"));
				} else {
					$('#new_link_tags').find('.link_tag[data-id="'+this.model.get("id")+'"]').remove();
					Links.addTags.splice(Links.addTags.indexOf(this.model.get("id")), 1);
				}
			}
		},
		
		toggle : function(){
			if (contributing == false && !$('#linkList').is(":hidden")){
				if (this.$('.tag_option').hasClass('selected')) {
					Links.queryParams.splice(Links.queryParams.indexOf(this.model.get("id")), 1);
					Links.query();
					this.$('.tag_option').removeClass('selected');
				} else {
					Links.queryParams.push(this.model.get("id"));
					Links.query();
					this.$('.tag_option').addClass('selected');
				}
			}
		}
	})
	
	window.TagListView = Backbone.View.extend({
		initialize : function(){
			_.bindAll(this);
						
			Tags.bind('add', this.addOne);
			Tags.bind('reset', this.addAll);
			
			$('.new_tag_field').addDefaultText();
			$('.new_tag_field').keydown(function(event){
				if (event.keyCode == 13) {
					Tags.create({name : $.trim($(this).text()), group : $(this).closest('.left_container').data('group')});
					$(this).text('').blur();
				}
			})
			
		},

		addOne : function(tag){
			var view = new TagView({model : tag});
			$('.left_container[data-group='+tag.get("group")+']').find('.tag_list').append(view.render().el)
		},
		
		addAll : function(){
			Tags.each(this.addOne);
		}
		
	})
	
	new TagListView();

})