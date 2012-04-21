jQuery(function($){
	$('#user_form').find('input').addDefaultText();
	if ($.trim($('#editable_description').text()).length == 0) $('#editable_description').addDefaultText('Write something about yourself')
	$('#update_user').click(function(){
		var sendData = {};
		if ($('#editable_description').text() == $('#editable_description').data('default')) $('#editable_description').val('')
		sendData['description'] = $('#editable_description').text();
		$.post('/save', {user : sendData}, function(){
			showError('Changes Saved');
		})
	})
})