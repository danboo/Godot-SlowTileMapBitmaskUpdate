# Godot-SlowTileMapBitmaskUpdate

Working with a large (millions of cells) TileMap I found that updating the autotile bitmask using the easiest, built-in method was slower than I could afford. After trying some alternate methods I found faster ways to update, but the result was unintuitive.

On my computer with a 1000x1000 TileMap I got the following results:

1. tilemap.update_bitmask_region() - 7.1 seconds

	This is letting the engine update the entire TileMap by calling the method with no arguments. I'd actually expect this to be the fastest way to update the tilemap since it isn't iterating through a GDScript loop and calling into engine code. It is wholly contained in the C++ code.

2. tilemap.update_bitmask_region(Vector2(min_x, min_y), Vector2(max_x, max_y)) - 1.7 seconds

	I thought this would have the same performance as the default call in example 1, just with explicit bounds.

3. tilemap.update_bitmask_area(Vector2()) - 0.9 seconds

	In this method I iterate through the rows and columns in GDScript, calling this method for every 3rd cell. I thought this would be the slowest method since it has the overhead of the GDScript loop and method calls.



