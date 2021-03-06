module.exports = (grunt) ->

  grunt.initConfig

    pkg: grunt.file.readJSON 'package.json'

    copy:
      static:
        expand: true, cwd: 'src/', src: '*.html', dest: 'build/'
      images:
        expand: true, cwd: 'images/', src: ['*.png', '*.jpg'], dest: 'build/images/'
      press:
        expand: true, cwd: 'press/', src: ['*.pdf','*.mov','*.zip'], dest: 'build/press/'

    less:
      main:
        files:
          'build/css/style.css':'src/less/style.less'
          'build/css/press.css':'src/less/press.less'

    coffee:
      main:
        files:
          'build/js/app.js':'src/coffee/app.coffee'

    watch:
      main:
        files: ['src/less/*.less', 'src/*.html', 'src/coffee/*.coffee']
        tasks: ['build']

    cssmin:
      combine:
        files:
          'build/css/style.css':['lib/reset.css', 'lib/jquery.fullPage.css', 'build/css/style.css']
          'build/css/press.css':['lib/reset.css', 'build/css/press.css']

    uglify:
      js:
        files:
          'build/js/app.js':['lib/jquery.easings.min.js', 'lib/jquery.fullPage.min.js', 'build/js/app.js']

    compress:
      dist:
        options:
          archive: 'dist/<%= pkg.name %>-v<%= pkg.version %>.zip'
        files:
          [expand: true, cwd: 'build/', src: ['**'], dest: 'dist/<%= pkg.name %>-v<%= pkg.version %>/']

  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-cssmin'
  grunt.loadNpmTasks 'grunt-contrib-compress'

  grunt.registerTask 'build', ['coffee:main', 'less:main', 'copy:static', 'copy:images', 'cssmin:combine', 'uglify:js']
  grunt.registerTask 'dist', ['build', 'compress:dist']
  grunt.registerTask 'default', ['build']
