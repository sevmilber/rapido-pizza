App.foods = App.cable.subscriptions.create "FoodsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $(".welcome #main").html(data.html)
