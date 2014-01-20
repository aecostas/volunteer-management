views = {}
views.sideMenu = require "views/sidemenu"

class SideMenu extends Spine.Controller

	constructor: ->
		super
		@render()
		
	render: () =>
		console.warn @items
		_.each @items, (value, key) =>
			console.warn "main: #{key}"
			menuitem={}
			menuitem.main = key
			menuitem.elements = @items[key]
		
			@append views.sideMenu menuitem


module.exports = SideMenu