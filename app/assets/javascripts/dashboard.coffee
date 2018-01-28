$ ->
  $('select.list-input, select.assignee-input').on 'change', ->
    if @value
      $(this).closest('form').submit()
