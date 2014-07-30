# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('#ori_image').change ->
    file_data = $(this).prop("files")[0]
    form_data = new FormData()
    form_data.append('file-object', file_data)
    form_data.append('file-type', 'jpg,jpeg,gif,tiff,png,bmp')
    $.ajax
      url: '/upload_origin_image'
      dataType: 'json'
      data: form_data
      type: 'post'
      contentType: false
      cache: false
      processData: false
      success: (data) ->
        $('.jc-demo-box img').attr('src', data.img)

  $('#cropimg').submit ->
    x = $('#x').val()
    y = $('#y').val()
    w = $('#w').val()
    h = $('#h').val()

    $.ajax
      url: '/upload_thumbnail'
      dataType: 'json'
      type: 'post'
      data: {x: x, y: y, w: w, h: h}
      success: (data) ->
        $('.avatar img').attr('src', data.img)

    return false

# show page
$ ->
  $('#file').change ->
    readURL(this)

  readURL = (input) ->
    url = input.value
    ext = url.substring(url.lastIndexOf('.') + 1).toLowerCase()
    if (input.files && input.files[0]&& (ext == "gif" || ext == "png" || ext == "jpeg" || ext == "jpg"))
      reader = new FileReader()
      reader.onload = (e) ->
        $('#thumbnil').attr('src', e.target.result)
      reader.readAsDataURL(input.files[0])
    else
      $('#thumbnil').attr('src', '/assets/no_preview.png')