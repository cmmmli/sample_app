$(function() {
  var chapter_num = $('.js-book_chapter').length;
  var chapter_num2 = $('.js-book_chapter').length + 1;
  $('#add_item_button').on('click', function() {
    var input =
        '<div class="js-book_chapter input-group" id="add_chapter_' + chapter_num + '">'
        + '<input class="form-control" placeholder="' + chapter_num2 + '章" type="text" name="book[chapters_attributes][' + chapter_num + '][title]" id="book_chapters_attributes_' + chapter_num + '_title" required>'
        + '<span class="chapter_delete input-group-btn" data-id="' + chapter_num + '">'
        +   '<button type="button" class="btn btn-warning">-</button>'
        + '</span>'
        +'</div>'
    $('#book_chapters_box').append(input);
    chapter_num ++;
    chapter_num2 ++;
  });

  $('#book_chapters_box').on('click', '.chapter_delete', function() {
    var inputId = $(this).data('id');
    var defaultData = $(this).data('default');
    if (defaultData == 'default') {
      $(this).prev().prop('checked', true);
      $('#add_chapter_' + inputId).hide();
    }else{
      $('#add_chapter_' + inputId).remove();
    }
  });
});
