randomize();

test = new RoomGenerator(21, 15, [
	new Entrance(10, 0, TileType.BasicFloor, [
		TileType.BasicFloor,
		TileType.Water
	]),
	new Entrance(20, 7, TileType.Water, [
		TileType.BasicFloor,
		TileType.Water
	]),
	new Entrance(0, 7, TileType.BasicFloor, [
		TileType.BasicFloor
	]),
	new Entrance(10, 14, TileType.BasicFloor, [
		TileType.BasicFloor
	])
], [
	TileType.BasicFloor,
	TileType.BasicWall,
	TileType.Water,
	TileType.Box
]);

test.generate();