$(function(){
  var toggleEditForm = function(id) {
    $('.js-info-name[data-id=' + id + ']').toggleClass('hidden');
    $('.js-edit-form[data-id=' + id + ']').toggleClass('hidden');
  };

  $('.js-edit').on('click', function(){
    toggleEditForm($(this).data().id);
  });

  $('.js-cancel').on('click', function(){
    toggleEditForm($(this).data().id);
  });
});

