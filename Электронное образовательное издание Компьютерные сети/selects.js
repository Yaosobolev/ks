$(document).ready(function () {
	$('#field4').change(function () {
		var field4 = $(this).val();
		if (field4 == '0') {
			$('#field5').html('');
			$('#field5').attr('disabled', true);
			return(false);
		}
		$('#field5').attr('disabled', true);
		$('#field5').html('<option>ЗАГРУЗКА...</option>');
		
		var url = 'get_spec.php';
		
		$.get(
			url,
			"field4=" + field4,
			function (result) {
				if (result.type == 'error') {
					alert(error);
					return(false);
				}
				else {
					var options = '';
					$(result.specc).each(function() {
						options .= '<option value="' + $(this).attr('id') + '">' + $(this).attr('title') + '</option>';
					});
					$('#field5').html(options);
					$('#field5').attr('disabled', false);
				}
			},
			"json"
		);
	});
});