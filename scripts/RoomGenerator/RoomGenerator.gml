enum TileType
{
    None,
    BasicFloor,
    BasicWall,
	Water,
	Box
}

/// @desc Function Description
/// @param {Real} _x Description
/// @param {Real} _y Description
function Position(_x, _y) constructor
{
	x = floor(_x);
	y = floor(_y);
}

/**
 * Function Description
 * @param {Real} _x Description
 * @param {Real} _y Description
 * @param {Enum.TileType} _firstTile Description
 * @param {Array<Enum.TileType>} _walkableTiles Description
 */
function Entrance(_x, _y, _firstTile, _walkableTiles) constructor
{
	pos = new Position(_x, _y);
	firstTile = _firstTile;
	walkableTiles = _walkableTiles;
}

/// @param {Struct.Position} _pos
/// @param {Enum.TileType} _type
function Tile(_pos, _type) constructor
{
	pos = _pos;
	type = _type;
}

/**
 * Function Description
 * @param {Real} _width Description
 * @param {Real} _height Description
 * @param {Array<Struct.Entrance>} _entrances Description
 * @param {Array<Enum.TileType>} _availableTiles
 */
function RoomGenerator(_width, _height, _entrances, _availableTiles) constructor
{
	width = floor(_width);
	height = floor(_height);
	grid = array_create(width);
	availableTiles = _availableTiles;
	
	for(i = 0; i < width; ++i)
	{
		grid[i] = array_create(height, TileType.None)
	}
	
	entrances = _entrances;
	
	/// @param {Struct.Position} pos
	/// @param {Array<Array<Bool>>} walked
	isTileValid = function(pos, walked)
    {
        return !(pos.x <= 0 || pos.y <= 0 || pos.x >= width - 1 || pos.y >= height - 1 || walked[pos.x][pos.y]);
    }

	/// @param {Struct.Tile} tile
	/// @param {Array<Struct.Tile>} tiles
	/// @param {Array<Array<Bool>>} walked
    getNeighborTiles = function(tile, tiles, walked)
    {
        newTile = new Tile(new Position(tile.pos.x + 1, tile.pos.y), tile.type);
        if(isTileValid(newTile.pos, walked) && !array_any(tiles, function(t){return t.pos.x == newTile.pos.x && t.pos.y == newTile.pos.y}))
        {
            array_push(tiles, newTile);
        }
		
        newTile = new Tile(new Position(tile.pos.x - 1, tile.pos.y), tile.type);
        if(isTileValid(newTile.pos, walked) && !array_any(tiles, function(t){return t.pos.x == newTile.pos.x && t.pos.y == newTile.pos.y}))
        {
            array_push(tiles, newTile);
        }
		
        newTile = new Tile(new Position(tile.pos.x, tile.pos.y + 1), tile.type);
        if(isTileValid(newTile.pos, walked) && !array_any(tiles, function(t){return t.pos.x == newTile.pos.x && t.pos.y == newTile.pos.y}))
        {
            array_push(tiles, newTile);
        }
		
        newTile = new Tile(new Position(tile.pos.x, tile.pos.y - 1), tile.type);
        if(isTileValid(newTile.pos, walked) && !array_any(tiles, function(t){return t.pos.x == newTile.pos.x && t.pos.y == newTile.pos.y}))
        {
            array_push(tiles, newTile);
        }
    }
	
	print = function()
	{
        for(i = 0; i < height; ++i)
        {
			str = "";
            for(j = 0; j < width; ++j)
            {
				str = str + "[" + string(grid[j][i]) + "]";
            }
			show_debug_message(str);
        }
		show_debug_message("\n");
	}
	
	makeBase = function()
	{
        for(i = 0; i < width; ++i)
        {
            for(j = 0; j < height; ++j)
            {
                if(i == 0 || j == 0 || i == width - 1 || j == height - 1)
                {
                    grid[i][j] = TileType.BasicWall;
                }
            }
        }

		array_foreach(entrances, function(entrance)
		{
			grid[entrance.pos.x][entrance.pos.y] = TileType.BasicFloor;
		})
	}
	
	fillNonWalkable = function(startTile, type)
	{
        possibleTiles = [startTile];
		fillType = type;

        while(1)
        {
            newTiles = [];

            array_foreach(possibleTiles, function(tile)
            {
                walkedGrid[tile.pos.x][tile.pos.y] = true;
				grid[tile.pos.x][tile.pos.y] = fillType;
                getNeighborTiles(tile, newTiles, walkedGrid);
				newTiles = array_filter(newTiles, function(t)
				{
					return grid[t.pos.x][t.pos.y] == TileType.None;
				})
            });

            possibleTiles = variable_clone(newTiles);

			print()

            if(array_length(possibleTiles) == 0){break;}
        }
	}
	
	makeNonWalkable = function()
	{
		tileTypes = variable_clone(availableTiles);
		
		for(i = 0; i < array_length(entrances); ++i)
		{
			for(j = 0; j < array_length(entrances[i].walkableTiles); ++j)
			{
		        if(array_contains(tileTypes, entrances[i].walkableTiles[j]))
				{
		            array_filter(tileTypes, function(t){return t != entrances[i].walkableTiles[j]});
				}
			}
		}
		
        for(i = 1; i < width - 1; ++i)
        {
            for(j = 1; j < height - 1; ++j)
            {
                if(grid[i][j] == TileType.None)
				{
					rand = irandom(array_length(tileTypes) - 1);
					
					type = tileTypes[rand]
					fillNonWalkable(new Tile(new Position(i, j), type), type);
				}
            }
        }
	}
	
	generate = function()
	{
		makeBase()
		
		array_foreach(entrances, function(entrance)
		{
			walkableTiles = entrance.walkableTiles;
            possibleTiles = [];

            walkedGrid = array_create(width);
			
			for(i = 0; i < width; ++i)
			{
				 walkedGrid[i] = array_create(height, false)
			}
			
			getNeighborTiles(new Tile(entrance.pos, entrance.firstTile), possibleTiles, walkedGrid);

            startBias = 6;

            while(1)
            {
                newTiles = [];

                array_foreach(possibleTiles, function(tile)
                {
                    walkedGrid[tile.pos.x][tile.pos.y] = true;
					rand = irandom(3 + startBias);
                    if(rand > 0)
                    {
						rand = irandom(3 + startBias);
						if(rand > 0)
						{
							grid[tile.pos.x][tile.pos.y] = tile.type;
						}else
						{
							rand = irandom(array_length(walkableTiles) - 1);
							grid[tile.pos.x][tile.pos.y] = walkableTiles[rand];
						}
                        getNeighborTiles(tile, newTiles, walkedGrid);
                    }
                });

                possibleTiles = variable_clone(newTiles);

				print()

                if(array_length(possibleTiles) == 0){break;}
                if(startBias > 0){startBias -= 2;}

                if(startBias == 0 && array_any(possibleTiles, function(tile){
					t = tile;
					return array_any(walkableTiles, function(type){
						return grid[t.pos.x][t.pos.y] == type;
					});
				}))
                {
                    break;
                }
            }
		});
		
		//makeNonWalkable();
		
		print();
	}
}