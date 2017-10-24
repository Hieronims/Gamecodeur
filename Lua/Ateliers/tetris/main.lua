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

local currentTetros = 3
local currentRotation = 1
function love.load()
  
  largeur = love.graphics.getWidth()
  hauteur = love.graphics.getHeight()
  
end

function love.update(dt)

end

function love.draw()
    local shape = tetros[currentTetros][currentRotation]
	
	for l=1,#shape do
		for c=1, #shape[l] do
			local x = (l - 1 ) * 32
			local y = (c - 1 ) * 32
			if shape[l][c] == 1 then
				love.graphics.setColor(255 , 255 , 255)
				love.graphics.rectangle("fill", x, y, 31, 31)
			else
				love.graphics.setColor(255 , 0 , 0)
				love.graphics.rectangle("fill", x, y, 31, 31)
			end
		end
	end
	
end

function love.keypressed(key)
	print (#tetros)
  
-- faire tourner le tetromino  
	if key == "right" then
		currentRotation = currentRotation + 1  
		if currentRotation > #tetros[currentTetros] then
			currentRotation = 1	
		end
	
	end
	if key == "left" then
		currentRotation = currentRotation - 1  
		if currentRotation < 1 then
			currentRotation = #tetros[currentTetros]
		end
	end
-- passer au tetromino suivant

	if key == "space" then
		currentTetros = currentTetros + 1
		if currentTetros > #tetros then
		currentTetros = 1
		end
		
	end
	

  
end
