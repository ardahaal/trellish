$.widget "trellish.taskHandler",
  _create: ->
    @selects = @element.find('select.list-input, select.assignee-input')
    @_setup_event_handlers()

  _setup_event_handlers: ->
    @selects.on 'change', (e) =>
      if $(e.target).val()
        $(e.target).closest('form').submit()

$ ->
  $("li.task").each ->
    $(this).taskHandler()

  $('#task_filter').keyup (e) ->
    $.ajax
      url: $(this).closest('form')[0].action
      headers:
        'Accept': 'text/javascript; charset=utf-8'
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
      type: 'POST'
      data:
        'task_filter': @value
        'authenticity_token': $(this).siblings('#authenticity_token').val()
    false
