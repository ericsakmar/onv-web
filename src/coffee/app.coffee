document.getElementById('down-button').onclick = (evt) -> 
  y = window.pageYOffset
  console.log window.innerHeight, y
  
  next = ''
  if y < window.innerHeight
    next = '#save'
  else if y < window.innerHeight * 2
    next = '#about'
  else if y < window.innerHeight * 3
    next = '#about2'
  else if y < window.innerHeight * 4
    next = '#media'
  else
    next = '#main'

  console.log next
  smoothScroll.animateScroll(document.getElementById('down-button'), next)

smoothScroll.init()
