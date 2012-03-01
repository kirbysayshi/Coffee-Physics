### HSHGCollisionDemo ###
class HSHGCollisionDemo extends Demo

    setup: ->

        super

        # Verlet gives us collision responce for free!
        @physics.integrator = new Verlet()

        min = new Vector 0.0, 0.0
        max = new Vector @width, @height

        bounds = new EdgeBounce min, max
        attraction = new Attraction @mouse.pos, 2000, 1400

        collide = new WorldHashedCollision
        @physics.worldBehaviours.push collide

        for i in [0..350]

            p = new Particle (Random 0.5, 4.0)
            p.setRadius p.mass * 4

            p.moveTo new Vector (Random @width), (Random @height)

            # Connect to spring or move free.
            if Random.bool 0.35
                s = new Spring @mouse, p, (Random 120, 180), 0.8
                @physics.springs.push s
            else
                p.behaviours.push attraction

            # Add particle to collision pool.
            collide.grid.addObject p

            # Allow particle to collide.
            p.behaviours.push bounds

            @physics.particles.push p