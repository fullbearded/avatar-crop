# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('#choose-image', '#set-avatar').change ->
    file_data = $(this).prop("files")[0]
    return unless file_data?

    form_data = new FormData()
    form_data.append('file-object', file_data)
    success_handler = (data) ->
      $('img', '#set-avatar').attr('src', data.origin_avatar)
      $('#uploaded', '#set-avatar').val(true)

    error_handler = (data) ->

    $.ajax
      url: 'create_avatar'
      dataType: 'json'
      data: form_data
      type: 'post'
      contentType: false
      processData: false
      success: success_handler
      error: error_handler

  preview_middle = $('.preview-thumb .middle-size')
  preview_middle_content = preview_middle.find('.image-wrapper')
  preview_middle_img = preview_middle_content.find('img')
  middle_x_size = preview_middle_content.width()
  middle_y_size = preview_middle_content.height()

  preview_small = $('.preview-thumb .small-size')
  preview_small_content = preview_small.find('.image-wrapper')
  preview_small_img = preview_small_content.find('img')
  small_x_size = preview_small_content.width()
  small_y_size = preview_small_content.height()

  boundx = 450
  boundy = 450

  updatePreview = (c) ->
    if (parseInt(c.w) > 0)
      middle_x_ratio = middle_x_size / c.w
      middle_y_ratio = middle_y_size / c.h

      preview_middle_img.css
        width: Math.round(middle_x_ratio * boundx) + 'px'
        height: Math.round(middle_y_ratio * boundy) + 'px'
        marginLeft: '-' + Math.round(middle_x_ratio * c.x) + 'px'
        marginTop: '-' + Math.round(middle_y_ratio * c.y) + 'px'

      small_x_ratio = small_x_size / c.w
      small_y_ratio = small_y_size / c.h

      preview_small_img.css
        width: Math.round(small_x_ratio * boundx) + 'px'
        height: Math.round(small_y_ratio * boundy) + 'px'
        marginLeft: '-' + Math.round(small_x_ratio * c.x) + 'px'
        marginTop: '-' + Math.round(small_y_ratio * c.y) + 'px'

      $('#crop-x').val(c.x)
      $('#crop-y').val(c.y)
      $('#crop-w').val(c.w)
      $('#crop-h').val(c.h)
      return

  $('#target', '#set-avatar').Jcrop
    onChange: updatePreview
    onSelect: updatePreview
    bgOpacity: 0.5
    aspectRatio: 1  # 缩放比例
    minSize: [90, 90]
    setSelect: [179, 179, 180, 180]
    allowSelect: false

  $('.operation .submit', '#set-avatar').click ->
    data =
      crop_x: $('#crop-x').val()
      crop_y: $('#crop-y').val()
      crop_w: $('#crop-w').val()
      crop_h: $('#crop-h').val()
      uploaded: $('#uploaded').val()

    success_handler = (data) ->
      $("#set-avatar").modal('hide')
      $('#index-avatar').attr('src', data.avatar)

    error_handler = (data) ->

    $.ajax
      url: 'update_avatar'
      data: data
      type: 'put'
      success: success_handler
      error: error_handler

  $('#set-avatar').on 'hidden.bs.modal', ->
    $('#choose-image', '#set-avatar').val(null)

  return