
class WorldHashedCollision extends Collision

	constructor: (@callback=null) ->

		@grid = new HSHG();

		super

	apply: (world, dt, index) ->

		@grid.update()
		pairs = @grid.queryForCollisionPairs()

		for pair, index in pairs
			@collide pair[0], pair[1]