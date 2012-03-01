### Particle ###
class Particle

	constructor: (@mass = 1.0) ->

		# Set initial mass.
		@setMass @mass

		# Set initial radius.
		@setRadius 1.0

		# Apply forces.
		@fixed = false;

		# Behaviours to be applied.
		@behaviours = []

		# Current position.
		@pos = new Vector()

		# Current velocity.
		@vel = new Vector()

		# Current force.
		@acc = new Vector()

		# Previous state.
		@old =
			pos: new Vector()
			vel: new Vector()
			acc: new Vector()

		@aabb = 
			min: [0, 0]
			max: [0, 0]


	### Moves the particle to a given location vector. ###
	moveTo: (pos) ->

		@pos.copy pos
		@old.pos.copy pos

	### Sets the mass of the particle. ###
	setMass: (@mass = 1.0) ->

		# The inverse mass.
		@massInv = 1.0 / @mass;

	### Sets the radius of the particle. ###
	setRadius: (@radius = 1.0) ->

		@radiusSq = @radius * @radius

	getAABB: () ->

		@aabb.min[0] = @pos.x - @radius
		@aabb.min[1] = @pos.y - @radius
		@aabb.min[2] = @pos.y - @radius

		@aabb.max[0] = @pos.x + @radius
		@aabb.max[1] = @pos.y + @radius
		@aabb.max[2] = @pos.y + @radius

		return @aabb

	### Applies all behaviours to derive new force. ###
	update: (dt, index) ->

		# Apply all behaviours.

		if not @fixed
			
			for behaviour in @behaviours

				behaviour.apply @, dt, index