$(document).ready ->
  $('#movie_collection_name').autocomplete
    source: "/ajax/collections"
    select: (event,ui) ->
      $("#post_collection_id").val(ui.item.id)