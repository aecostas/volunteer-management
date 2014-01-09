class StageScoring extends Spine.Model
	@configure 'StageScoring','stage','participant','c1','c2','c3'
#	@extend Spine.Model.Local

	update: (e)->
		console.warn "Updating!!!! #{e}"
		super

	remove: ->
		super

module.exports = StageScoring