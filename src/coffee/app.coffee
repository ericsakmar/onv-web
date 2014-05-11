  
sectionChanged = (toggle, anchor) ->
  
  next = switch anchor
    when '#main' then '#save'
    when '#save' then '#about'
    when '#about' then '#about2'
    when '#about2' then '#media'
    else '#main'

  document.getElementById('down-button').onclick = (evt) ->
    smoothScroll.animateScroll(null, next)

smoothScroll.init
  callbackAfter: sectionChanged



