--Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

-- Empèche Love de filtrer les contours des images quand elles sont redimentionnées
-- Indispensable pour du pixel art
love.graphics.setDefaultFilter("nearest")

-- Cette ligne permet de déboguer pas à pas dans ZeroBraneStudio
if arg[#arg] == "-debug" then require("mobdebug").start() end

local tetros = {}

tetros[1] = {
	{
		{0,0,0,0},
		{0,0,0,0},
		{1,1,1,1},
		{0,0,0,0},
	},
	{
		{0,1,0,0},
		{0,1,0,0},
		{0,1,0,0},
		{0,1,0,0},
	}
}

tetros[2] = {
	{
		{0,0,0,0},
		{0,1,1,0},
		{0,1,1,0},
		{0,0,0,0},
	}		
}
tetros[3] = {
	{
		{0,0,0},
		{1,1,1},
		{0,0,1},
	},
	{
		{0,1,0},
		{0,1,0},
		{1,1,0},
	},
	{
		{1,0,0},
		{1,1,1},
		{0,0,0},
	},
	{
		{0,1,1},
		{0,1,0},
		{0,1,0},
	}
}

tetros[4] = {
	{
		{0,0,0},
		{1,1,1},
		{1,0,0},
	},
	{
		{1,1,0},
		{0,1,0},
		{0,1,0},
	},
	{
		{0,0,1},
		{1,1,1},
		{0,0,0},
	},
	{
		{0,1,0},
		{0,1,0},
		{0,1,1},
	}
}
tetros[5] = {
	{
		{0,0,0},
		{0,1,1},
		{1,1,0},
	},
	{
		{1,0,0},
		{1,1,0},
		{0,1,0},
	}
}
tetros[6] = {
	{
		{0,0,0},
		{1,1,1},
		{0,1,0},
	},
	{
		{0,1,0},
		{1,1,0},
		{0,1,0},
	},
	{
		{0,1,0},
		{1,1,1},
		{0,0,0},
	},
	{
		{0,1,0},
		{0,1,1},
		{0,1,0},
	}
}
tetros[7] = {
	{
		{0,0,0},
		{1,1,0},
		{0,1,1},
	},
	{
		{0,1,0},
		{1,1,0},
		{1,0,0},
	}
}


local currentTetros = {}
currentTetros.shapeid = 1 -- forme
currentTetros.rotation = 1
currentTetros.position = { x=1, y=1 }

local grid = {}
grid.offsetX = 0
grid.offsetY = 0
grid.width = 10
grid.height = 20
grid.ceilSize = 0 
grid.cells = {}

function SpawnTetros()
  local new = math.random(1 , #tetros)
  currentTetros.shapeid = new
  currentTetros.rotation = 1
  local tetrosWidth = #tetros[currentTetros.shapeid][currentTetros.rotation][1]
  currentTetros.position.x = (math.floor((grid.width - tetrosWidth) / 2)) + 1 -- Pourquoi + 1 / A cause de l'arrondi :-)
  currentTetros.position.y = 1
end


function InitGrid()
  local h = hauteur / grid.height
  grid.cellSize = h -- On définit la taille d'une cellule en hauteur et largeur par rapport à la hauteur et la taille de la grille
  grid.offsetX = (largeur / 2 ) -  ((grid.cellSize * grid.width) /2 )
  grid.offsetY = 0
  grid.cells = {}
  for l=1, grid.height do
    grid.cells[l] = {}
    for c=1, grid.width do
      grid.cells[l][c] = 0
    end
  end
end


function love.load()
  
  largeur = love.graphics.getWidth()
  hauteur = love.graphics.getHeight()
  InitGrid()
  SpawnTetros()
end

function love.update(dt)
 
end
function DrawGrid()
  local h = grid.cellSize 
  local w = h
  love.graphics.setColor(255, 255, 255, 50)
  local x,y
  for l=1,grid.height do
    grid.cells[l]= {}
    for c=1, grid.width do
      x = (c-1)*w
      y = (l-1)*h
      x = x + grid.offsetX
      y = y + grid.offsetY
      love.graphics.rectangle("fill", x, y, w-1, h-1 )
    end
  end
  

end
function DrawShape(pShape, pColumn, pLine)
  love.graphics.setColor (255, 0, 0)
   for l=1,#pShape do 
      for c=1, #pShape[l] do
        local x = (c-1) * grid.cellSize
        local y = (l-1) * grid.cellSize
        -- Ajouter la position de la pièce
        x = x + (pColumn -1) * grid.cellSize
        y = y + (pLine   -1) * grid.cellSize
        -- Ajout de la position de la grille
        x = x + grid.offsetX
        y = y + grid.offsetY
        if pShape[l][c] == 1 then
          love.graphics.rectangle("fill", x, y, grid.cellSize - 1, grid.cellSize - 1)
        end
      end
    end
end

function love.draw()
  
  local shape = tetros[currentTetros.shapeid][currentTetros.rotation]
	DrawShape(shape, currentTetros.position.x, currentTetros.position.y)
	DrawGrid() -- Dessine la grille
  
end

function love.keypressed(key)

  
-- faire tourner le tetromino  
	if key == "right" then
		currentTetros.rotation = currentTetros.rotation + 1  
		if currentTetros.rotation > #tetros[currentTetros.shapeid] then
			currentTetros.rotation = 1	
		end
	
	end
	if key == "left" then
		currentTetros.rotation = currentTetros.rotation - 1  
		if currentTetros.rotation < 1 then
			currentTetros.rotation = #tetros[currentTetros.shapeid]
		end
	end
-- passer au tetromino suivant

	if key == "space" then
		currentTetros.shapeid = currentTetros.shapeid + 1
    currentTetros.rotation = 1
		if currentTetros.shapeid > #tetros then
		currentTetros.shapeid = 1
    
		end
		
	end
	

  
end
