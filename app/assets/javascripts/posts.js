$(function(){
  $('.js-select2-select').select2({
    theme: "bootstrap",
    tags: true,
    allowClear: true
  });

  $('#like-form, #unlike-form')
    .on('ajax:success', function(){
      location.reload();
    })
    .on('ajax:error', function(){
      console.error('Error');
    });
});

