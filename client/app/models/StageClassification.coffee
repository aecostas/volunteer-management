class StageClassification extends Spine.Model
	@configure 'StageClassification','stage','participant','c1','c2','c3'
#	@extend Spine.Model.Local

	update: (e)->
		console.warn "Updating!!!! #{e}"
		super

	remove: ->
		super
	
module.exports = StageClassification