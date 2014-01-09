# See http://brunch.readthedocs.org/en/latest/config.html for documentation.
exports.config =
  
  paths:
    public: 'public'

  files:
    javascripts:
      defaultExtension: 'coffee'
      joinTo:
        'js/app.js': /^app/
        'js/vendor.js': /^vendor/
        # 'javascripts/app.js': /^app/
        # 'javascripts/vendor.js': /^vendor/
        # 'test/javascripts/test.js': /^test(\/|\\)(?!vendor)/
        # 'test/javascripts/test-vendor.js': /^test(\/|\\)(?=vendor)/
      order:
        before: [
          'vendor/scripts/console.js'
          'vendor/scripts/auto-reload-brunch.js'
          'vendor/scripts/jquery.js'
          # Twitter Bootstrap jquery plugins
          'vendor/scripts/bootstrap/bootstrap-transition.js'
          'vendor/scripts/bootstrap/bootstrap-affix.js'
          'vendor/scripts/bootstrap/bootstrap-alert.js'
          'vendor/scripts/bootstrap/bootstrap-button.js'
          'vendor/scripts/bootstrap/bootstrap-carousel.js'
          'vendor/scripts/bootstrap/bootstrap-collapse.js'
          'vendor/scripts/bootstrap/bootstrap-dropdown.js'
          'vendor/scripts/bootstrap/bootstrap-modal.js'
          'vendor/scripts/bootstrap/bootstrap-scrollspy.js'
          'vendor/scripts/bootstrap/bootstrap-tab.js'
          'vendor/scripts/bootstrap/bootstrap-tooltip.js'
          'vendor/scripts/bootstrap/bootstrap-popover.js'
          'vendor/scripts/bootstrap/bootstrap-typeahed.js'
          # Spine JS
          'vendor/scripts/spine/spine.js'
          'vendor/scripts/spine/ajax.js'
          'vendor/scripts/spine/list.js'
          'vendor/scripts/spine/manager.js'
          'vendor/scripts/spine/relation.js'
          'vendor/scripts/spine/route.js'
          'vendor/scripts/spine/local.js'

		  # OpenLayers
          'vendor/scripts/OpenLayers.js'

          # moment
          'vendor/scripts/moment.min.js'
			
        ]

    stylesheets:
      defaultExtension: 'stylus'
      joinTo: 
        'css/app.css': /^(app|vendor)/
        # 'stylesheets/app.css': /^(app|vendor)/


    templates:
      defaultExtension: 'jade'
      joinTo: 'js/app.js'
