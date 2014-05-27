window.requestAnimFrame = window.requestAnimationFrame || window.webkitRequestAnimationFrame || window.mozRequestAnimationFrame || (callback) -> window.setTimeout(callback, 1000 / 60)

document.getElementById('down-button').onclick = (evt) -> 
  y = window.pageYOffset
  
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

  smoothScroll.animateScroll(document.getElementById('down-button'), next)

window.addEventListener "scroll", (evt) ->
  y = window.pageYOffset
  
  if y < window.innerHeight * 2
    document.getElementById('main-link').classList.add('active')
    document.getElementById('about-link').classList.remove('active')
    document.getElementById('about2-link').classList.remove('active')
    document.getElementById('media-link').classList.remove('active')
  else if y < window.innerHeight * 3
    document.getElementById('main-link').classList.remove('active')
    document.getElementById('about-link').classList.add('active')
    document.getElementById('about2-link').classList.remove('active')
    document.getElementById('media-link').classList.remove('active')
  else if y < window.innerHeight * 4
    document.getElementById('main-link').classList.remove('active')
    document.getElementById('about-link').classList.remove('active')
    document.getElementById('about2-link').classList.add('active')
    document.getElementById('media-link').classList.remove('active')
  else
    document.getElementById('main-link').classList.remove('active')
    document.getElementById('about-link').classList.remove('active')
    document.getElementById('about2-link').classList.remove('active')
    document.getElementById('media-link').classList.add('active')
  
setUpClouds = (canvasId, images) ->
  width = window.innerWidth
  height = window.innerHeight

  canvas = document.getElementById canvasId
  canvas.width = width
  canvas.height = height

  numClouds = Math.floor(width / 200) + Math.floor(height / 300)

  clouds = (makeCloud(i, width, height, images) for i in [1..numClouds])

  draw = ->
    requestAnimFrame(draw)
    ctx = document.getElementById(canvasId).getContext('2d')

    ctx.clearRect(0, 0, width, height)

    for cloud in clouds
      cloud.x = cloud.x - (cloud.speed / 5)

      if cloud.x < 0 - cloud.img.width
        cloud.x = width
        cloud.y = getRandom(0, height)

      ctx.drawImage(cloud.img,cloud.x,cloud.y);

  draw()

makeCloud = (index, width, height, images) -> 
  cloud = 
    img: new Image
    speed: getRandom(1, 5)
    x: getRandom(0, width)
    y: getRandom(0, height)
  cloud.img.src = images[getRandom(0, images.length - 1)]
  cloud

getRandom = (min, max) -> Math.floor(Math.random() * (max - min + 1)) + min

# DOING STUFF
smoothScroll.init()
setUpClouds('main-canvas', ['images/cloud-dark-1.png', 'images/cloud-dark-2.png', 'images/cloud-dark-3.png', 'images/cloud-dark-4.png'])
setUpClouds('about-canvas', ['images/cloud-light-1.png', 'images/cloud-light-2.png', 'images/cloud-light-3.png'])
setUpClouds('about-canvas-2', ['images/cloud-light-1.png', 'images/cloud-light-2.png', 'images/cloud-light-3.png'])
setUpClouds('media-canvas', ['images/cloud-light-1.png', 'images/cloud-light-2.png', 'images/cloud-light-3.png'])