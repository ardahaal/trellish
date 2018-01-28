$ ->
  $('select.list-input').on 'change', ->
    if @value
      $(this).closest('form').submit()
